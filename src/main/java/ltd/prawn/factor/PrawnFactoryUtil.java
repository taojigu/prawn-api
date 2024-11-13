package ltd.prawn.factor;

import java.util.Random;

public class PrawnFactoryUtil {

    public static long getPositiveLong(long limit) {
        Random random = new Random();
        long i = random.nextLong();
        if (i < 0) {
            i = -i;
        }
        i %= limit;
        return i;
    }

}
