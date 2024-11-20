package ltd.prawn.config.annotation;

import java.lang.annotation.*;

@Target({ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface TokenToPrawnUser {

    /**
     * 当前用户在request中的名字
     *
     * @return
     */
    String value() default "prawnUser";

}