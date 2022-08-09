# flutter_py_kiot

## This APP
* uses chaquopy plugin in order to run python code, the Vimar KIOT python library.
* uses test server setup for the Vimar DRSE hackathon summer 2022 and precooked authentication
* reads all lights of the plant and speaks out status
* polls every 10 seconds for state change and speak it out, only when there is a state change

To be continued with:
* print status in widget (one or one for each)
* use firebase to get status notifications

## Getting Started 
APP use chaquopy open source release: v12.0.1 (2022 07 24)
https://chaquo.com/chaquopy/doc/current/android.html#android-plugin
Required steps to setup are described also in chaquopy flutter documentation https://pub.dev/packages/chaquopy
The latter documentation is obsolete.
Since the documentation is quite distributed, I put all here:

* changes to build.gradle of the project, under android_
    * check that mavenCentral is in, add dependency to chaquo, add plugin entry and chaquo
    * buildscript {
        ...
        repositories {
            mavenCentral()
        }

        dependencies {
            classpath 'com.android.tools.build:gradle:7.1.2'
            classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
            classpath 'com.chaquo.python:gradle:12.0.1'
        }
    }

    plugins {
        id 'com.chaquo.python' version '12.0.1' apply false
    }
* changes to build.gradle in android->app
    * add plugin for chaquo just after android, add nkd fields and python pip commands
    *   apply plugin: 'com.android.application'
        apply plugin: 'com.chaquo.python'
        defaultConfig {
            ...
            ndk {
                abiFilters "armeabi-v7a", "arm64-v8a", "x86", "x86_64"
            }
            python {
                pip {
                    // An sdist or wheel filename, relative to the project directory:
                    // project directory means from andriod/app
                    install "requests"
                    install "../../../../Python/KIOT lib/vimar_kiot-1.0.0-py3-none-any.whl"
                }
            }    
        }
* Add this line to application tag in manifest file: android:name="com.chaquo.python.android.PyApplication".
* add this file that must be called "script.py"
    * https://drive.google.com/file/d/1D4Hjt66f0MXkaeAQ8WLX3DEebX3BrFvM/view
    * to the directory <project name>/android/app/src/main/python
    * the directory is created by the chaquopy

Please note that during development I found a bug, I opened an issue, mr. davidyuk proposed a correction and after that Jay Ashokbhai Dangar corrected the repo. Everithing should be OK, in any case you can find the correction below.
* file "ChaquopyPlugin.kt" correction below from davidyuk

* APP uses KIOT python library from Mariano Sciacco's thesis @ Vimar S.p.A.
    Here all the references
    * usiamo KIOT: https://bitbucket.org/vimarspa/aei_tesi_knxiot3rdparty_client/src/develop/
    * https://vimarspa.atlassian.net/wiki/spaces/IEF/pages/63932222570590/Hackathon+DRSE+-+1st+edition#Quali-sono-i-dati-di-accesso?

You can find in directory /demo a sample python code to change lights status (in order to make the APP demo if nobody pushes buttons on the physical installation):
* main_set.py

* APP uses The plugin flutter_tts requires Android SDK min 21 (substitute the flutter.minSdkVersion)
    * G:\Dev\Flutter\flutter_py_kiot\android\app\build.gradle
        android {
          defaultConfig {
            minSdkVersion 21
          }
        }

## History
First version of APP used chaquopy v12.0.0 with this problems:
* the app does not build, does not take latest-version of chaquo
* the app does not build due to a kotlin problem
* the app crashes after 5 minutes because that version is not open needs licensing, as described in faq #1 here https://pub.dev/packages/chaquopy#faqs

Solved:
* version error
    I had to change this in the project "build.gradle", section dependencies:
        classpath "com.chaquo.python:gradle:latest-version"
    into this:
        classpath 'com.chaquo.python:gradle:12.0.0'
    because it was not capable to resolve it.
* Build ERROR, davidyuk helps:
    
      I had the same problem, as a workaround fixed it by changing
        -val code: String = call.arguments()
        +val code: String = call.arguments() ?: ""
      in ChaquopyPlugin.kt
    
    I find the file here C:\Portable\flutter\.pub-cache\hosted\pub.dartlang.org\chaquopy-0.0.16\android\src\main\kotlin\com\chaquopy\chaquopy
    Still to understand how to fix it automatically in installation, and not manually every time.

NOT solved
* app crash
    This is from Debug console:
        W/python.stderr( 9902): Unlicensed copy of Chaquopy: app will now shut down. See https://chaquo.com/chaquopy/license/
        W/python.stderr( 9902):
        F/libc    ( 9902): Fatal signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 0x0 in tid 10156 (Thread-6), pid 9902 (flutter_py_kiot)

    Correction suggested here: https://chaquo.com/chaquopy/license/
    Closed-source Chaquopy versions (12.0.0 and older) will display a license warning on startup, and will only run for 5 minutes at a time. To remove these restrictions, add the following line to your project’s local.properties file:
        chaquopy.license=free
    The notification and time limit will then be removed the next time you build the project.

    The suggestion does not solve, it does not build:
        A problem occurred configuring project ':chaquopy'.
        When building a library module with a license key, local.properties must contain a chaquopy.applicationId line identifying the app which the library will be built into.

TODO