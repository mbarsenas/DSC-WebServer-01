Configuration WebServerConfig {
    Node "WebServer-01" {
        WindowsFeature WebServer {
            Name = "Web-Server"
            Ensure = "Present"
        }
    }
}
WebServerConfig