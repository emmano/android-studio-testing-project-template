package ${packageName};

import com.robotium.solo.Solo;

import android.test.ActivityInstrumentationTestCase2;

import ${packageName}.${activityClass};

public class ${activityClass}RobotiumTest extends ActivityInstrumentationTestCase2<${activityClass}> {

    private Solo solo;

    public ${activityClass}RobotiumTest() {
        super(${activityClass}.class);
    }

    public void setUp() throws Exception {
        solo = new Solo(getInstrumentation(), getActivity());
    }

    public void testSomeTest() throws Exception {
        assertTrue(solo.searchText("Hello world"));
    }

    @Override
    public void tearDown() throws Exception {
        solo.finishOpenedActivities();
    }
}