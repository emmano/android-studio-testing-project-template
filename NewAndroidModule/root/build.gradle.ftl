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
    all*.exclude group: 'asm', module: 'asm'
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
        testInstrumentationRunner "com.google.android.apps.common.testing.testrunner.GoogleInstrumentationTestRunner"

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
        androidTest.java.srcDirs = ['src/androidTest/java', 'src/androidTestRobotium/java', 'src/androidTestEspresso/java']
        androidTest.assets.srcDirs = ['src/androidTest/assets', 'src/androidTestRobotium/assets', 'src/androidTestEspresso/assets']
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

    compile('org.roboguice:roboguice:2.0') {
        exclude group: 'aopalliance'
        exclude group: 'org.sonatype.sisu.inject'
    }
    compile 'com.android.support:support-v4:21.0.0'
    androidTestCompile('com.google.dexmaker:dexmaker-mockito:1.0') {
        exclude group: 'com.google.dexmaker', module: 'dexmaker'
    }
    compile 'com.squareup.retrofit:retrofit:1.5.1'
    compile 'com.squareup:otto:1.3.+'
    compile 'com.squareup.picasso:picasso:2.3.+'
    androidTestCompile 'com.jayway.android.robotium:robotium-solo:5.2.1'
    androidTestProvided 'com.jeskeshouse:injected-test-runner:1.0'
    androidTestCompile'com.jakewharton.espresso:espresso:1.1-r3'
    androidTestCompile 'com.jakewharton.espresso:espresso-support-v4:1.1-r3'
    robolectricCompile 'junit:junit:4.10'
    robolectricCompile 'org.mockito:mockito-all:1.9.0'
    robolectricCompile 'com.google.android:android:4.1.1.4'
    robolectricCompile('org.roboguice:roboguice:2.0') {
        exclude group: 'aopalliance'
        exclude group: 'org.sonatype.sisu.inject'
    }

    androidTestProvided 'junit:junit:4.10'

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
