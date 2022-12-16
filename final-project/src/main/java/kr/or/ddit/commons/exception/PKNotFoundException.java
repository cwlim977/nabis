package kr.or.ddit.commons.exception;

public class PKNotFoundException extends RuntimeException {

	public PKNotFoundException() {
		super();
	}

	public PKNotFoundException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public PKNotFoundException(String pk, Throwable cause) {
		super(String.format("%s에 해당하는 데이터가 없다.", pk), cause);
	}

	public PKNotFoundException(String pk) {
		super(String.format("%s에 해당하는 데이터가 없다.", pk));
	}

	public PKNotFoundException(Throwable cause) {
		super(cause);
	}
	
}
