FROM microsoft/windowsservercore:ltsc2016

MAINTAINER AbhishekKumar.Gupta@softwareag.com

COPY ./jvm/jvm/ C:/SoftwareAG912/jvm/jvm/
ENV JAVA_HOME C:/SoftwareAG912/jvm/jvm/

ENV D_INSTANCE_NAME=default

COPY ./install/jars/ C:/SoftwareAG912/install/jars/
COPY ./install/profile/ C:/SoftwareAG912/install/profile/
COPY ./install/products/ C:/SoftwareAG912/install/products/

COPY ./Licenses/sagosch.exe C:/SoftwareAG912/Licenses/sagosch.exe

COPY ./common/bin/ C:/SoftwareAG912/common/bin/
COPY ./common/conf/ C:/SoftwareAG912/common/conf/
COPY ./common/lib/ C:/SoftwareAG912/common/lib/
COPY ./common/runtime/ C:/SoftwareAG912/common/runtime/
COPY ./common/security/ C:/SoftwareAG912/common/security/

COPY ./WS-Stack/ C:/SoftwareAG912/WS-Stack/

COPY ./IntegrationServer/bin/ C:/SoftwareAG912/IntegrationServer/bin/
COPY ./IntegrationServer/lib/ C:/SoftwareAG912/IntegrationServer/lib/
COPY ./IntegrationServer/sdk/ C:/SoftwareAG912/IntegrationServer/sdk/
COPY ./IntegrationServer/updates/ C:/SoftwareAG912/IntegrationServer/updates/
COPY ./IntegrationServer/web/ C:/SoftwareAG912/IntegrationServer/web/

COPY ./IntegrationServer/.tc.dev.log4j.properties C:/SoftwareAG912/IntegrationServer/.tc.dev.log4j.properties

COPY ./IntegrationServer/instances/${D_INSTANCE_NAME}/ C:/SoftwareAG912/IntegrationServer/instances/${D_INSTANCE_NAME}/
COPY ./IntegrationServer/instances/lib/ C:/SoftwareAG912/IntegrationServer/instances/lib/
COPY ./IntegrationServer/instances/is_instance.xml C:/SoftwareAG912/IntegrationServer/instances/is_instance.xml
COPY ./IntegrationServer/instances/is_instance.bat C:/SoftwareAG912/IntegrationServer/instances/is_instance.bat
COPY ./profiles/IS_${D_INSTANCE_NAME}/ C:/SoftwareAG912/profiles/IS_${D_INSTANCE_NAME}/

RUN del C:\SoftwareAG912\IntegrationServer\instances\default\config\repository4.cnf
RUN del C:\SoftwareAG912\IntegrationServer\instances\default\config\security\keystore\default_is_keystore_ks_config.xml
RUN del C:\SoftwareAG912\IntegrationServer\instances\default\config\security\keystore\default_is_truststore_ts_config.xml
RUN C:\SoftwareAG912\IntegrationServer\instances\is_instance.bat updateDockerConfigFiles -Dinstance.name=default
#RUN C:\SoftwareAG912\IntegrationServer\instances\is_instance.bat create-osgi-profile -Dinstance.name=default

CMD C:\SoftwareAG912\IntegrationServer\instances\default\bin\startup.bat

EXPOSE 5555
EXPOSE 9999
