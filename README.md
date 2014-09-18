android-studio-testing-project-template
=======================================

The goal of this project is to speed up the setup of Robolectric, Robotuim, Roboguice, and Mockito in Android Studio. Since there is not built in support for Robolectric (just yet, hopefully) there is a lot of manual set up that has to be done. This project uses [jeske717's](https://github.com/jeske717) Robolectric-gralde plugin as well as his InjectedTestRunner (more about it later) found on Java Center. 


### How is this different than the [Deckard-Gradle](https://github.com/robolectric/deckard-gradle) template provided by Robolectric?

Deckard requires you to download their template and then customize things like the name of your project, module name, etc. This template is configured with the information provided when you go through the project creation flow.

Tested on:

- Mac OSX (Mavericks)
- Android Studio 0.8.1 and 0.8.5


Set Up
========================================
1. Clone the repo
2. Go to your Android Studio installation fodler, and then to `plugins/android/lib/templates/gradle-projects`
3. Create a backup of the `NewAndroidProject` and `NewProjectTemplate` folders (just in case you want to revert the changes)
4. Copy the two folders you just cloned into the `plugins/android/lib/templates/gradle-projects`
5. Open Android Studio and create a new project
6. After build.gradle gets executed by Android Studio, you would get a dialog saying that the *.iml file was updated and the project needs to be reloaded. Click on OK. (if the dialog doesn't show automatically you should manually run the `addRobolectricTestSourcesToIml` Gradle task (see below on how to run Gradle tasks)).
7. Upon restart the `robolectricTest/java` directory should be green. Now you need to run the `configureJUnitDefaultToUseRobolectricClasspath` Gradle task. To do so, go to `View-> Tool Windows->Gradle`. Expand the menu that has the name of your app, and double click on the `configureJUnitDefaultToUseRobolectricClasspath` task. Android studio will prompt the same message as before (requesting to reload the project). Click OK.
8. After Android Studio reloads, you should syncronize your project. `File->Syncrhonize`.
9. Run the `MyActivityRobolectricTest.java` inside the robolectricTest module. Right click on the method, `Run>testMethodName()` (the second option on the dropdown; the JUnit one).
10. Go to Android Studio > Preferences > Compiler > uncheck "Use in-process build" 
11. As part of the Espresso configuration a custom Run Configuration is needed. They show how to do it on their docs [here](https://code.google.com/p/android-test-kit/wiki/Espresso) (look at the Android Studio picture). Make sure you check the "Show chooser dialog". It defaults to Emulator.
12. If everything is set up correclty, the test should run and pass.

InjectedTestRunner
========================================

`InjectedTestRunner` is the "glue" between Mockito and Roboguice. It basically looks for all `@Mock` on the test and automagically(thanks to jeske717) binds the mock instance to the correct `@Inject` on the implementation class. For more information go [here](https://github.com/jeske717/injected-test-runner)

Known Limitations (We will try to fix)
========================================
1. You might encounter some problems when trying to add a new package under `robolectricTest/java/your.app.package`
2. After you create a new test on a class that already contains tests, sometimes you will need to run the tests twice if you are running all the tests on the class. Synchronizing the project also works. It seems that gralde doesn't pick up the new added test on the first run. It works on the second run. (Step 10 above should fix this)
3. Make sure you create the project setting KitKat as `minSdk` to begin with. Tried using a different `minSdk` during the project creation flow and it broke the template. You can change your `minSdk` after you follow the steps above.
4. Specifying to use the GoogleInstrumentationTestRunner in `build.gradle`, as required by Espresso, makes the whole test suite run. Removing `testInstrumentationRunner "com.google.android.apps.common.testing.testrunner.GoogleInstrumentationTestRunner"` from `build.gradle`, allows to run Robotium tests independently, but Espresso tests will not run. I will try to find a way to separate the runs.


TODO
========================================
1. Be able to run Robotium and Espresso tests independently


