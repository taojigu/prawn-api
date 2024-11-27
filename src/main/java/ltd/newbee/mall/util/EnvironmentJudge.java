package ltd.newbee.mall.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public class EnvironmentJudge {

    private final Environment environment;

    @Autowired
    public EnvironmentJudge(Environment environment) {
        this.environment = environment;
    }

    /**
     * Check if the current environment is 'dev'.
     * @return true if the 'dev' profile is active.
     */
    public boolean isDev() {
        return isProfileActive("dev");
    }

    /**
     * Check if the current environment is 'test'.
     * @return true if the 'test' profile is active.
     */
    public boolean isTest() {
        return isProfileActive("test");
    }

    /**
     * Check if the current environment is 'staging'.
     * @return true if the 'staging' profile is active.
     */
    public boolean isStaging() {
        return isProfileActive("staging");
    }

    /**
     * Check if the current environment is 'prod'.
     * @return true if the 'prod' profile is active.
     */
    public boolean isProd() {
        return isProfileActive("prod");
    }

    /**
     * Helper method to determine if a specific profile is active.
     * @param profile The profile name to check.
     * @return true if the given profile is active.
     */
    private boolean isProfileActive(String profile) {
        String[] activeProfiles = environment.getActiveProfiles();
        for (String activeProfile : activeProfiles) {
            if (activeProfile.equalsIgnoreCase(profile)) {
                return true;
            }
        }
        return false;
    }
}
