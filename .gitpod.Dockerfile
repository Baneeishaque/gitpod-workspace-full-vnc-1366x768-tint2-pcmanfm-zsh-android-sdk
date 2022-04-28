FROM baneeishaque/gitpod-workspace-full-vnc-1366x768-tint2-pcmanfm-zsh

ARG androidCommandLineToolsLinuxDownloadUrl="https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip"
#TODO : Get filename from URL
ARG androidCommandLineToolsLinuxInstallationFile="commandlinetools-linux-8092744_latest.zip"

RUN cd $HOME \
 && wget $androidCommandLineToolsLinuxDownloadUrl \
 && unzip $androidCommandLineToolsLinuxInstallationFile \
 && mkdir -p Android/Sdk/cmdline-tools/latest \
 && mv cmdline-tools/* Android/Sdk/cmdline-tools/latest/ \
 && rmdir cmdline-tools/ \
 && rm $androidCommandLineToolsLinuxInstallationFile

ENV JAVA_HOME="$HOME/.sdkman/candidates/java/current"

ARG androidPlatformVersion="android-32"
ARG androidBuildToolsVersion="32.0.0"
ARG androidSourcesPlatformVersion="android-31"
# ARG androidPlatformPreviewVersion="android-S"
# ARG androidBuildToolsPreviewVersion="31.0.0-rc1"
# ARG cmakeVersion="3.10.2.4988404"
# ARG ndkVersion="22.0.7026061"

# RUN yes | Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses \
 # && Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platforms;$androidPlatformVersion" "build-tools;$androidBuildToolsVersion" "sources;$androidPlatformVersion" "platforms;$androidPlatformPreviewVersion" "build-tools;$androidBuildToolsPreviewVersion" "cmake;$cmakeVersion" "ndk;$ndkVersion"

# RUN yes | Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses \
 # && Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platforms;$androidPlatformVersion" "build-tools;$androidBuildToolsVersion" "sources;$androidPlatformVersion" "cmake;$cmakeVersion" "ndk;$ndkVersion"

RUN yes | Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses \
 && Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platforms;$androidPlatformVersion" "build-tools;$androidBuildToolsVersion" "platforms;$androidSourcesPlatformVersion" "sources;$androidSourcesPlatformVersion"

# RUN yes | Android/Sdk/cmdline-tools/latest/bin/sdkmanager --licenses

ENV ANDROID_SDK_ROOT="$HOME/Android/Sdk"

ENV PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
