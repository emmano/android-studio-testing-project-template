package ${packageName};

import com.jeskeshouse.injectedtestrunner.InjectedTestRunner;

import android.app.Activity;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.robolectric.Robolectric;
import org.robolectric.annotation.Config;

import static junit.framework.Assert.assertTrue;
@Config(emulateSdk = 18)
@RunWith(InjectedTestRunner.class)
public class ${activityClass}RobolectricTest {

   @Test
    public void testSomething() throws Exception {
        Activity activity = Robolectric.buildActivity(${activityClass}.class).create().get();
        assertTrue(activity != null);
    }
}
