android-studio-testing-project-template
=======================================

The goal of this project is to speed up the setup of Robolectric, Robotuim, Roboguice, and Mockito in Android Studio. Since there is not built in support for Robolectric (just yet, hopefully) there is a lot of manual set up that has to be done. This project uses jeske717's Robolectric-gralde plugin as well as his InjectedTestRunner (more about it later) found on Java Central.


Set Up
=======================================
1. Clone the repo
2. Go to your Android Studio installation fodler, and then to `plugins/android/lib/templates/gradle-projects`
3. Create a backup of the `NewAndroidProject` and `NewProjectTemplate` folders (just in case you want to revert the changes)
4. Copy the two folders you just cloned into the `plugins/android/lib/templates/gradle-projects`
5. Open Android Studio and create a new project
6. After build.gradle gets executed by Android Studio, you would get a dialog saying that the *.iml file was updated and the project needs to be reloaded. Click on OK. (if the dialog doesn't show automatically you should manually run the `addRobolectricTestSourcesToIml` Gradle task (see below on how to run Gradle tasks)).
7. Upon restart the `robolectricTest/java` directory should be green. Now you need to run the `configureJUnitDefaultToUseRobolectricClasspath` Gradle task. To do so, go to `View-> Tool Windows->Gradle`. Expand the menu that has the name of your app, and double click on the `configureJUnitDefaultToUseRobolectricClasspath` task. Android studio will prompt the same message as before (requesting to reload the project). Click OK.
8. After Android Studio reloads, you should syncronize your project. `File->Syncrhonize`.
9. Run the `MyActivityRobolectricTest.java` inside the robolectricTest module.
10. If everything is set up correclty, the test should run and pass.

InjectedTestRunner
========================================

`InjectedTestRunner` is the "glue" between Mockito and Roboguice. It basically looks for all @Mock on the test and automagically(thanks to jeske717) binds the mock instance to the correct @Inject on the implementation class. For more information go [here](https://github.com/jeske717/injected-test-runner) 



