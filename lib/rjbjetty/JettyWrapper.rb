require 'buildr'


module Buildr
class JettyWrapper

    attr_accessor :port , :webApp , :contextPath , :requestLog

    def start
        
        _JettyServer = Rjb::import('org.mortbay.jetty.Server')

        _BoundedThreadPool = Rjb::import('org.mortbay.thread.BoundedThreadPool')
        _Connector = Rjb::import('org.mortbay.jetty.Connector')

        _HandlerCollection =
            Rjb::import('org.mortbay.jetty.handler.HandlerCollection')
        _ContextHandlerCollection =
            Rjb::import('org.mortbay.jetty.handler.ContextHandlerCollection')
        _SelectChannelConnector =
            Rjb::import('org.mortbay.jetty.nio.SelectChannelConnector')

        _WebAppDeployer = 
            Rjb::import('org.mortbay.jetty.deployer.WebAppDeployer')

        _WebAppContext = Rjb::import("org.mortbay.jetty.webapp.WebAppContext")
        _RequestLogHandler = 
            Rjb::import('org.mortbay.jetty.handler.RequestLogHandler')

        _DefaultHandler = 
            Rjb::import('org.mortbay.jetty.handler.DefaultHandler')
        _NCSARequestLog = Rjb::import('org.mortbay.jetty.NCSARequestLog')
        server = _JettyServer.new

#    threadPool = BoundedThreadPool.new
#    threadPool.setMaxThreads(100)
#    server.setThreadPoll threadPool

        connector = _SelectChannelConnector.new
        connector.setPort(@port)
        server.setConnectors([connector])

        handlers = _HandlerCollection.new
        contexts = _ContextHandlerCollection.new
        requestLogHandler = _RequestLogHandler.new
        defaultHandler = _DefaultHandler.new
        handlers.setHandlers [contexts,defaultHandler,requestLogHandler]
        server.setHandler handlers

        webAppContext = _WebAppContext.new @webApp, @contextPath
        server.setHandler webAppContext

        requestLog = _NCSARequestLog.new @requestLog 
        requestLog.setExtended false
        requestLogHandler.setRequestLog requestLog

        server.setStopAtShutdown true
        server.setSendServerVersion true

        server.start

    end

end
end
