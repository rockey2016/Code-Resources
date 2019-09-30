# 主循环

```
@file:glances.__init__.py

def start(config, args):
    """Start Glances."""

    # Load mode
    global mode

    if core.is_standalone():
        from glances.standalone import GlancesStandalone as GlancesMode
    elif core.is_client():
        if core.is_client_browser():
            from glances.client_browser import GlancesClientBrowser as GlancesMode
        else:
            from glances.client import GlancesClient as GlancesMode
    elif core.is_server():
        from glances.server import GlancesServer as GlancesMode
    elif core.is_webserver():
        from glances.webserver import GlancesWebServer as GlancesMode

    # Init the mode
    logger.info("Start {} mode".format(GlancesMode.__name__))
    mode = GlancesMode(config=config, args=args)

    # Start the main loop
    mode.serve_forever()

    # Shutdown
    mode.end()
```



在客户端通过glances -s server命令，执行体如下：

```
    def serve_forever(self):
        """Main client loop."""

        # Test if client and server are in the same major version
        '''_login_glances（）:
        1、初始化ServerProxy
        2、新建GlancesStatsClient，并通过初始化ServerProxy：getAllPlugins加载插件plugins
        '''
        if not self.login():  
            logger.critical("The server version is not compatible with the client")
            self.end()
            return self.client_mode

        exitkey = False
        try:
            while True and not exitkey:
                # Update the stats
                cs_status = self.update()

                # Update the screen
                if not self.quiet:
                    exitkey = self.screen.update(self.stats,
                                                 cs_status=cs_status,
                                                 return_to_browser=self.return_to_browser)

                # Export stats using export modules
                self.stats.export(self.stats)
        except Exception as e:
            logger.critical(e)
            self.end()

        return self.client_mode
        
@file glaneces:client.py        
##　update()-->   update_glances()     
            def update_glances(self):
        """Get stats from Glances server.

        Return the client/server connection status:
        - Connected: Connection OK
        - Disconnected: Connection NOK
        """
        # Update the stats
        try:
            server_stats = json.loads(self.client.getAll())
        except socket.error:
            # Client cannot get server stats
            return "Disconnected"
        except Fault:
            # Client cannot get server stats (issue #375)
            return "Disconnected"
        else:
            # self.stats指代GlancesStatsClient，server_stats
            self.stats.update(server_stats)
            return "Connected"
```





# 监控信息输出

## csv

```
@file:glances_csv.py

def update(self, stats):
        """Update stats in the CSV output file."""
        # Get the stats
        all_stats = stats.getAllExportsAsDict(plugin_list=self.plugins_to_export())

        # Init data with timestamp (issue#708)
        if self.first_line:
            csv_header = ['timestamp']
        csv_data = [time.strftime('%Y-%m-%d %H:%M:%S')]

        # Loop over plugins to export
        for plugin in self.plugins_to_export():
            if isinstance(all_stats[plugin], list):
                for stat in all_stats[plugin]:
                    # First line: header
                    if self.first_line:
                        csv_header += ('{}_{}_{}'.format(
                            plugin, self.get_item_key(stat), item) for item in stat)
                    # Others lines: stats
                    csv_data += itervalues(stat)
            elif isinstance(all_stats[plugin], dict):
                # First line: header
                if self.first_line:
                    fieldnames = iterkeys(all_stats[plugin])
                    csv_header += ('{}_{}'.format(plugin, fieldname)
                                   for fieldname in fieldnames)
                # Others lines: stats
                csv_data += itervalues(all_stats[plugin])

        # Export to CSV
        if self.first_line:
            self.writer.writerow(csv_header)
            self.first_line = False
        self.writer.writerow(csv_data)
        self.csv_file.flush()
        


```





```
@file:stats.py
## 每一个export插件都有一个线程
   def export(self, input_stats=None):
        """Export all the stats.

        Each export module is ran in a dedicated thread.
        """
        # threads = []
        input_stats = input_stats or {}

        for e in self._exports:
            logger.debug("Export stats using the %s module" % e)
            thread = threading.Thread(target=self._exports[e].update,
                                      args=(input_stats,))
            # threads.append(thread)
            thread.start()


## 每个插件的状态以dict格式输出
    def getAllExportsAsDict(self, plugin_list=None):
        """
        Return all the stats to be exported (list).
        Default behavor is to export all the stat
        if plugin_list is provided, only export stats of given plugin (list)
        """
        if plugin_list is None:
            # All plugins should be exported
            plugin_list = self._plugins
        return {p: self._plugins[p].get_export() for p in plugin_list}
```



## 屏幕输出

```
@file:glances_curses.py

@file:glances_plugin.py

def get_stats_display(self, args=None, max_width=None)
        """Return a dict with all the information needed to display the stat.

        key     | description
        ----------------------------
        display | Display the stat (True or False)
        msgdict | Message to display (list of dict [{ 'msg': msg, 'decoration': decoration } ... ])
        align   | Message position
        """
        display_curse = False

        if hasattr(self, 'display_curse'):
            display_curse = self.display_curse
        if hasattr(self, 'align'):
            align_curse = self._align

        if max_width is not None:
            ret = {'display': display_curse,
                   'msgdict': self.msg_curse(args, max_width=max_width),
                   'align': align_curse}
        else:
            ret = {'display': display_curse,
                   'msgdict': self.msg_curse(args),
                   'align': align_curse}

        return ret

```












# 插件

## processlist

```
# 插件逻辑
@file:glances_processlist.py

    def update(self):
        """Update processes stats using the input method."""
        # Init new stats
        stats = self.get_init_value()

        if self.input_method == 'local':
            # Update stats using the standard system lib
            # Note: Update is done in the processcount plugin
            # Just return the processes list
            stats = glances_processes.getlist()

        elif self.input_method == 'snmp':
            # No SNMP grab for processes
            pass

        # Update the stats
        self.stats = stats

        # Get the max values (dict)
        # Use Deep copy to avoid change between update and display
        self.max_values = copy.deepcopy(glances_processes.max_values())

        return self.stats
```

