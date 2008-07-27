require 'buildr'
#require 'buildr/java/artifact'
#require 'buildr/java/java'

require 'rjbjetty/JettyWrapper'

module Buildr
    class RjbJetty
        JETTY_VERSION = "6.1.2"
        REQUIRES=[
            "org.mortbay.jetty:jetty:jar:#{JETTY_VERSION}",
            "org.mortbay.jetty:jetty-util:jar:#{JETTY_VERSION}",
            "org.mortbay.jetty:servlet-api-2.5:jar:#{JETTY_VERSION}",
            "org.mortbay.jetty:jsp-2.1:jar:#{JETTY_VERSION}",
            "org.mortbay.jetty:jsp-api-2.1:jar:#{JETTY_VERSION}",
            "log4j:log4j:jar:1.2.13",
            "commons-logging:commons-logging:jar:1.1"
        ];

        PORT = 8080
        WEBAPP = "src/main/webapp"
        CONTEXTPATH = "/"
        REQUEST_LOG = "logs/jetty-request.log"

        Java.classpath << REQUIRES 
        Java.classpath << './target/classes/'

#        print Java.classpath.join("\r\n")

        class << self
            def instance()
                @instance ||= RjbJetty.new
            end
        end

        attr_accessor :port , :webApp , :contextPath , :requestLog 
        
        def initialize() #:nodoc:
            @port = PORT
            @webApp = WEBAPP
            @contextPath = CONTEXTPATH
            @requestLog = REQUEST_LOG
        end

        def start 
            begin
                Java.rjb do 
                   jetty_wrapper = JettyWrapper.new
                   jetty_wrapper.port = @port
                   jetty_wrapper.webApp = @webApp
                   jetty_wrapper.contextPath = @contextPath
                   jetty_wrapper.requestLog = @requestLog
                   jetty_wrapper.start
                   sleep
                end
            rescue Interrupt
            rescue Exception => error
                puts "#{error.class}: #{error.message}"
            end
            exit!
        end

    end

    namespace "rjbjetty" do
        desc "rjb jetty starting."
        task("start") { RjbJetty.instance.start }
    end

    namespace "rj" do 
        desc "rjb-jetty staring."
        task("s") { RjbJetty.instance.start }
    end

    def rjbjetty()
        @rjbjetty ||= RjbJetty.instance
    end
end
