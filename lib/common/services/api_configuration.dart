enum ServiceHost { AWS, PrivateServer }

class ApiConfiguration {
  static const APP_VERSION = "1.1.7";
  static const IS_SECURED = false;
  static const ServiceHost CURRENT_SERVICE_HOST = ServiceHost.AWS;
  static const APP_HOST_NAME = "acadedge.com";
  static final serverBaseUrl = CURRENT_SERVICE_HOST == ServiceHost.AWS
      ? "ec2-13-232-46-155.ap-south-1.compute.amazonaws.com:8081"
      : APP_HOST_NAME;
}
