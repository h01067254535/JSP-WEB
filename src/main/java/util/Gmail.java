package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

//Mail 라이브러리 다운로드 사이트: http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-eeplat-419426.html#javamail-1.4.7-oth-JPR
//Activation 라이브러리 다운로드 사이트: http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-java-plat-419418.html#jaf-1.1-fr-oth-JPR
//출처: https://ndb796.tistory.com/40 [안경잡이개발자]
public class Gmail extends Authenticator{
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("h01067254535@gmail.com", "han4294535");
	}
}
