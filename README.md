# flutter_py_kiot
This APP
* uses chaquopy plugin in order to run python code, the Vimar KIOT python library.
* uses test server for the Vimar DRSE hackathon
* reads all lights of the plant and speaks out status
* polls every 10 seconds for state chance and speak it out

To be continued with:
* print status in widget (one or one for each)
* use firebase to get status notifications

## Getting Started and known issues up to first release
First version used v12.0.0 with this problems:
* the app does not build, does
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