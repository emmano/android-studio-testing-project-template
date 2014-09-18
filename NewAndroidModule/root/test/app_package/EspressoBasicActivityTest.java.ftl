package ${packageName};

import android.test.ActivityInstrumentationTestCase2;

import ${packageName}.${activityClass};

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;

public class ${activityClass}EspressoTest extends ActivityInstrumentationTestCase2<${activityClass}> {

    public ${activityClass}EspressoTest() {
        super(${activityClass}.class);
    }

    public void setUp() throws Exception {
        getActivity();
    }

    public void testSomeTest() throws Exception {
        onView(withText("Hello world!")).perform(click());
    }
}