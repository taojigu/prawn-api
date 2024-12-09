package ltd.prawn.common;

public class PrawnMallException extends RuntimeException {

    public PrawnMallException() {
    }

    public PrawnMallException(String message) {
        super(message);
    }

    /**
     * 丢出一个异常
     *
     * @param message
     */
    public static void fail(String message) {
        throw new PrawnMallException(message);
    }
}
