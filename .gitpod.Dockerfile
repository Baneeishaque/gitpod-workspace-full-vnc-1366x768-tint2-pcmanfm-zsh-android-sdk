FROM baneeishaque/gitpod-workspace-full-vnc-1366x768-tint2-pcmanfm-zsh

ARG androidCommandLineToolsLinuxDownloadUrl="https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip"
ARG androidCommandLineToolsLinuxInstallationFile="commandlinetools-linux-6858069_latest.zip"

RUN cd $HOME \
 && wget $androidCommandLineToolsLinuxDownloadUrl | tee -a /tmp/wget-androidCommandLineToolsLinux.log \
 && unzip $androidCommandLineToolsLinuxInstallationFile | tee -a /tmp/unzip-androidCommandLineToolsLinux.log\
 && mkdir -p Android/Sdk/cmdline-tools/latest \
 && mv cmdline-tools/* Android/Sdk/cmdline-tools/latest/ \
 && rmdir cmdline-tools/ \
 && rm $androidCommandLineToolsLinuxInstallationFile

ENV JAVA_HOME="$HOME/.sdkman/candidates/java/current"

ARG androidPlatformVersion="android-30"
ARG androidBuildToolsVersion="30.0.3"
# ARG androidPlatformPreviewVersion="android-S"
# ARG androidBuildToolsPreviewVersion="31.0.0-rc1"
# ARG cmakeVersion="3.10.2.4988404"
# ARG ndkVersion="22.0.7026061"

# RUN yes | Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses \
 # && Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platforms;$androidPlatformVersion" "build-tools;$androidBuildToolsVersion" "sources;$androidPlatformVersion" "platforms;$androidPlatformPreviewVersion" "build-tools;$androidBuildToolsPreviewVersion" "cmake;$cmakeVersion" "ndk;$ndkVersion"

# RUN yes | Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses \
 # && Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platforms;$androidPlatformVersion" "build-tools;$androidBuildToolsVersion" "sources;$androidPlatformVersion" "cmake;$cmakeVersion" "ndk;$ndkVersion"

RUN yes | Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses | tee -a /tmp/yes-androidSdkLicenses.log \
 && Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platforms;$androidPlatformVersion" "build-tools;$androidBuildToolsVersion" "sources;$androidPlatformVersion" | tee -a /tmp/androidSdkManager.log

ENV ANDROID_SDK_ROOT="$HOME/Android/Sdk"

