buildscript {
    repositories {
        mavenCentral()
        jcenter()
<#if mavenUrl != "mavenCentral">
        maven {
            url '${mavenUrl}'
        }
</#if>
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:${gradlePluginVersion}'
        classpath 'com.jakewharton.sdkmanager:gradle-plugin:0.12.+'
        classpath 'org.jesko.robolectric:robolectric-androidstudio-plugin:1.1.3'
    }
}

<#if isLibraryProject?? && isLibraryProject>
apply plugin: 'com.android.library'
<#else>
apply plugin: 'android-sdk-manager'
apply plugin: 'com.android.application'
apply plugin: 'robolectric'
</#if>



repositories {
        mavenCentral()
        jcenter()
<#if mavenUrl != "mavenCentral">
        maven {
            url '${mavenUrl}'
        }
</#if>
}

configurations {
    all*.exclude group: 'org.json'
    all*.exclude group: 'asm', module: 'asm', version: '3.1'
    all*.exclude group: 'stax'
    all*.exclude group: 'xpp3'
}

android {
    compileSdkVersion <#if buildApiString?matches("^\\d+$")>${buildApiString}<#else>'${buildApiString}'</#if>
    buildToolsVersion "${buildToolsVersion}"

    defaultConfig {
        applicationId "${packageName}"
        minSdkVersion <#if minApi?matches("^\\d+$")>${minApi}<#else>'${minApi}'</#if>
        targetSdkVersion <#if targetApiString?matches("^\\d+$")>${targetApiString}<#else>'${targetApiString}'</#if>
        versionCode 1
        versionName "1.0"
    }
    packagingOptions {
        exclude 'META-INF/LICENSE.txt'
        exclude 'LICENSE.txt'
        exclude 'META-INF/NOTICE.txt'
    }
    lintOptions {
        abortOnError false
    }

    sourceSets {
        androidTest.java.srcDirs = ['src/androidTest/java', 'src/androidTestRobotium/java']
        androidTest.assets.srcDirs = ['src/androidTest/assets', 'src/androidTestRobotium/assets']
    }

<#if javaVersion?? && javaVersion != "1.6">

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_${javaVersion?replace('.','_','i')}
        targetCompatibility JavaVersion.VERSION_${javaVersion?replace('.','_','i')}
    }
</#if>

}

dependencies {
    <#if dependencyList?? >
    <#list dependencyList as dependency>
    compile '${dependency}'
    </#list>
    </#if>

    apk 'org.slf4j:slf4j-android:1.7.7'

    compile 'org.slf4j:slf4j-api:1.7.7'
    compile 'com.squareup.retrofit:retrofit:1.5.1'
    compile 'com.android.support:support-v4:19.1.+'
    compile 'ch.acra:acra:4.5.0'
    compile('org.roboguice:roboguice:2.0') {
        exclude group: 'aopalliance'
        exclude group: 'org.sonatype.sisu.inject'
    }
    compile 'com.android.support:support-v4:19.1.+'
    compile 'com.jeskeshouse:injected-test-runner:1.0'
    compile 'com.google.code.gson:gson:2.2.+'
    compile 'com.squareup:otto:1.3.+'
    compile 'com.squareup.picasso:picasso:2.3.+'
    compile 'com.squareup.okhttp:okhttp:1.6.0'
    compile 'com.squareup.okhttp:okhttp-urlconnection:1.6.0'
    compile 'joda-time:joda-time:2.3'

    androidTestCompile('com.google.dexmaker:dexmaker-mockito:1.0') {
        exclude group: 'com.google.dexmaker', module: 'dexmaker'
    }
    androidTestCompile('com.squareup.okhttp:mockwebserver:1.6.0') {
        exclude group: 'com.squareup.okhttp', module: 'okhttp'
    }
    androidTestCompile 'com.jayway.android.robotium:robotium-solo:5.2.1'

    robolectricCompile 'junit:junit:4.10'
    robolectricCompile 'org.mockito:mockito-all:1.9.0'
    robolectricCompile 'com.google.android:android:4.1.1.4'
    robolectricCompile 'ch.acra:acra:4.5.0'
    robolectricCompile 'commons-io:commons-io:2.4'
    robolectricCompile 'com.google.guava:guava:16.0.1'
    robolectricCompile('org.roboguice:roboguice:2.0') {
        exclude group: 'aopalliance'
        exclude group: 'org.sonatype.sisu.inject'
    }
    robolectricCompile 'org.slf4j:slf4j-simple:1.7.7'


    androidTestProvided 'junit:junit:4.10'
    androidTestProvided('org.robolectric:robolectric:2.3') {
        exclude group: 'com.google.android'
    }
    compile fileTree(dir: 'libs', include: ['*.jar'])
<#if WearprojectName?has_content && NumberOfEnabledFormFactors?has_content && NumberOfEnabledFormFactors gt 1>
    wearApp project(':${WearprojectName}')
    compile 'com.google.android.gms:play-services-wearable:+'
</#if>
}
robolectric {
    imlFile 'app.iml'
    dotIdeaDir '../.idea'
    inProcessBuilds = false
}

tasks.withType(Test) {
    scanForTestClasses = false
    include "**/*Test.class"
}

gradle.projectsEvaluated {
    generateDebugSources.doLast {
        tasks['addRobolectricTestSourcesToIml'].execute()
    }
}
