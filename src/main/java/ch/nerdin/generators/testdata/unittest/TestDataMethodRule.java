package ch.nerdin.generators.testdata.unittest;

import org.junit.rules.TestWatchman;
import org.junit.runners.model.FrameworkMethod;

/**
 * This JUnit rule will ensure that when the test fail and then is rerun the same data is generated.
 * So that one can reproduce the failure.
 *
 * @author edewit
 */
public class TestDataMethodRule extends TestWatchman {

    @Override
    public void starting(FrameworkMethod method) {
        new SeedSaver().readSeed();
    }

    @Override
    public void failed(Throwable e, FrameworkMethod method) {
        new SeedSaver().writeSeed();
    }

    @Override
    public void succeeded(FrameworkMethod method) {
        new SeedSaver().deleteSeedFile();
    }
}
