package ${packageName};

import org.junit.runners.model.InitializationError;
import org.robolectric.AndroidManifest;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.res.Fs;

public class RobolectricGradleTestRunner extends RobolectricTestRunner {
    public RobolectricGradleTestRunner(Class<?> testClass) throws InitializationError {
        super(testClass);
    }



    @Override
    protected AndroidManifest getAppManifest(org.robolectric.annotation.Config config) {
        String pwd = MyApplication.class.getProtectionDomain().getCodeSource().getLocation().getPath();
        String root = pwd + "../../../../src/main/";

        return new AndroidManifest(
                Fs.fileFromPath(root + "AndroidManifest.xml"),
                Fs.fileFromPath(root + "res"),
                Fs.fileFromPath(root + "assets"));
    }
}