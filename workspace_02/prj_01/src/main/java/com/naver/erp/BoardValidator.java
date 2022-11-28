package com.naver.erp;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import java.util.regex.Pattern;

import javax.security.auth.Subject;


// BoardDTO 객체에 저장된 데이터의 유효성 체크를 실행할 BoardValidator 클래스 선언
public class BoardValidator implements Validator {
	
	private String upRegMode;
	
	public BoardValidator(String upRegMode) {
		this.upRegMode = upRegMode;
	}

	// 유효성 체크를 실행할 객체의 클래스 타입 정보를 얻어 리턴
	@Override
	public boolean supports(Class<?> arg0) {
		
		// 검증할 객체의 클래스 타입 정보
		return BoardDTO.class.isAssignableFrom(arg0);
	}

	// 유효성 체크를 실행할 메소드 선언
	@Override
	public void validate(
			
		// DTO 객체 저장 매개변수 선언
		Object obj
		
		// 유효성 체크 시 발생하는 에러를 관리하는
		// Errors 객체를 저장할 매개변수 선언
		, Errors errors
	) {
		try {
			
			// 유효성 체크를 실행할 DTO 객체 얻기
			BoardDTO dto = (BoardDTO)obj;
			
			String writer = dto.getWriter();
			
			// writer가 null일 경우 길이 없는 문자를 삽입
			if(writer==null) {
				writer = "";
			}
			
			// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 writer가 비거나 공백이면
			// 경고 메시지를 Errors 객체에 저장
			ValidationUtils.rejectIfEmptyOrWhitespace(
					
				// Errors 객체 선언
				errors
				
				// BoardDTO 객체의 속성변수명 선언
				, "writer"
					
				// BoardDTO 객체의 속성변수명이
				// 비거나 공백일 경우 보낼 경고 문구 설정
				, "작성자를 입력해주세요."
			);
			
			// Pattern 클래스의 matches 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 writer가 저장된 데이터의
			// 유효성 체크를 실행 후 유효성에 맞지 않을 경우
			// Errors 객체에 속성변수명 "writer"와 경고 메시지 저장
			// 한글 2~10자 체크
			if(Pattern.matches("^[가-힣]{2,10}$", writer)==false) {
			// java와 javascript의 정규표현식 차이에 주의
				
				errors.rejectValue("writer", "작성자는 한글 2~10자로 작성해주세요.");
			}
			
			
			
			// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 subject가 비거나 공백이면
			// 경고 메시지를 Errors 객체에 저장
			ValidationUtils.rejectIfEmptyOrWhitespace(
					
				// Errors 객체 선언
				errors
				
				// BoardDTO 객체의 속성변수명 선언
				, "subject"
					
				// BoardDTO 객체의 속성변수명이
				// 비거나 공백일 경우 보낼 경고 문구 설정
				, "제목을 입력해주세요."
			);
			
			String subject = dto.getSubject();
			
			// subject가 null일 경우 길이 없는 문자를 삽입
			if(subject==null) {
				subject = "";
			}
			
			// Pattern 클래스의 matches 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 subject가 저장된 데이터의
			// 유효성 체크를 실행 후 유효성에 맞지 않을 경우
			// Errors 객체에 속성변수명 "subject"와 경고 메시지 저장
			// 문자 개수 체크
			if(Pattern.matches("^.{1,17}$", subject)==false) {
			// java와 javascript의 정규표현식 차이에 주의
				
				errors.rejectValue("subject", "제목은 1~15자로 작성해주세요.");
			}
//			아래 코딩으로 대체 가능
//			if(subject.length()>15) {
//				errors.rejectValue("subject", "제목은 1~15자로 작성해주세요.");
//			}
			
			// Pattern 클래스의 matches 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 subject가 저장된 데이터의
			// 유효성 체크를 실행 후 유효성에 맞지 않을 경우
			// Errors 객체에 속성변수명 "subject"와 경고 메시지 저장
			// <script> 사용 여부 체크
			if(Pattern.matches(".*<script>.*", subject.toLowerCase())) {
			// java와 javascript의 정규표현식 차이에 주의
				
				errors.rejectValue("subject", "<script>는 사용할 수 없습니다.");
			}
//			아래 코딩으로 대체 가능
//			if(subject.toUpperCase().indexOf("<SCRIPT>")>=0) {
//				errors.rejectValue("subject", "<script>는 사용할 수 없습니다.");
//			}
//			또는 아래 코딩으로 대체 가능
//			해당 코드는 <Script> 등과 같은 대소문자가 섞여있는 문자는 체크 불가
//			if(Pattern.matches("(<script>|<SCRIPT>)", subject.toLowerCase())) {
//			// java와 javascript의 정규표현식 차이에 주의
//				
//				errors.rejectValue("subject", "<script>는 사용할 수 없습니다.");
//			}
			if(Pattern.matches(".*</script>.*", subject.toLowerCase())) {
			// java와 javascript의 정규표현식 차이에 주의
				
				errors.rejectValue("content", "<script> 태그는 사용할 수 없습니다.");
			}
			
			
			// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 content가 비거나 공백이면
			// 경고 메시지를 Errors 객체에 저장
			ValidationUtils.rejectIfEmptyOrWhitespace(
					
				// Errors 객체 선언
				errors
				
				// BoardDTO 객체의 속성변수명 선언
				, "content"
					
				// BoardDTO 객체의 속성변수명이
				// 비거나 공백일 경우 보낼 경고 문구 설정
				, "내용을 입력해주세요."
			);
			
			String content = dto.getContent();
			
			// content가 null일 경우 길이 없는 문자를 삽입
			if(content==null) {
				content = "";
			}
			
			// 내용에 엔터를 치면 500자 이내 오류 발생으로 인한
			// 공백이 2개 이상 일 경우
			// 공백을 1개로 만드는 코드 추가
			content = content.replaceAll("\\s+", " ");
//			System.out.println(content.length());
			
			// Pattern 클래스의 matches 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 content가 저장된 데이터의
			// 유효성 체크를 실행 후 유효성에 맞지 않을 경우
			// Errors 객체에 속성변수명 "content"와 경고 메시지 저장
			// 문자 개수 체크
			if(Pattern.matches("^.{1,500}$", content)==false) {
			// java와 javascript의 정규표현식 차이에 주의
				
				errors.rejectValue("content", "내용은 500자 이내로 작성해주세요.");
			}
//			아래 코딩으로 대체 가능
//			if(content.length()>15) {
//				errors.rejectValue("content", "내용은 500자 이내로 작성해주세요.");
//			}
			
			// Pattern 클래스의 matches 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 content가 저장된 데이터의
			// 유효성 체크를 실행 후 유효성에 맞지 않을 경우
			// Errors 객체에 속성변수명 "content"와 경고 메시지 저장
			// <script> 사용 여부 체크
			if(Pattern.matches(".*<script>.*", content.toLowerCase())) {
			// java와 javascript의 정규표현식 차이에 주의
				
				errors.rejectValue("content", "<script> 태그는 사용할 수 없습니다.");
			}
			
			if(Pattern.matches(".*</script>.*", content.toLowerCase())) {
			// java와 javascript의 정규표현식 차이에 주의
				
				errors.rejectValue("content", "<script> 태그는 사용할 수 없습니다.");
			}
			
			
			String email = dto.getEmail();
			
			// email가 null일 경우 길이 없는 문자를 삽입
			if(email==null) {
				email = "";
			}
			
			// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 email가 비거나 공백이면
			// 경고 메시지를 Errors 객체에 저장
			ValidationUtils.rejectIfEmptyOrWhitespace(
					
				// Errors 객체 선언
				errors
				
				// BoardDTO 객체의 속성변수명 선언
				, "email"
					
				// BoardDTO 객체의 속성변수명이
				// 비거나 공백일 경우 보낼 경고 문구 설정
				, "이메일을 입력해주세요."
			);
			
			// Pattern 클래스의 matches 메소드를 호출하여
			// BoardDTO 객체의 속성변수명 email가 저장된 데이터의
			// 유효성 체크를 실행 후 유효성에 맞지 않을 경우
			// Errors 객체에 속성변수명 "email"와 경고 메시지 저장
			// 이메일 형식 체크
			if(Pattern.matches("^[a-z0-9]+@[a-z]+\\.[a-z]{2,3}$", email)==false) {
			// java와 javascript의 정규표현식 차이에 주의
				
				errors.rejectValue("email", "이메일 형식에 맞지 않습니다.");
			}
			
			if(upRegMode.equals("reg")) {
				
				String pwd = dto.getPwd();
				
				// pwd가 null일 경우 길이 없는 문자를 삽입
				if(pwd==null) {
					pwd = "";
				}
				
				// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드를 호출하여
				// BoardDTO 객체의 속성변수명 pwd가 비거나 공백이면
				// 경고 메시지를 Errors 객체에 저장
				ValidationUtils.rejectIfEmptyOrWhitespace(
						
					// Errors 객체 선언
					errors
					
					// BoardDTO 객체의 속성변수명 선언
					, "pwd"
						
					// BoardDTO 객체의 속성변수명이
					// 비거나 공백일 경우 보낼 경고 문구 설정
					, "암호를 입력해주세요."
				);
				
				// Pattern 클래스의 matches 메소드를 호출하여
				// BoardDTO 객체의 속성변수명 pwd가 저장된 데이터의
				// 유효성 체크를 실행 후 유효성에 맞지 않을 경우
				// Errors 객체에 속성변수명 "pwd"와 경고 메시지 저장
				// 영소문자 또는 숫자이고 4자인지 체크
				if(Pattern.matches("^[a-z0-9]{4}$", pwd)==false) {
				// java와 javascript의 정규표현식 차이에 주의
					
					errors.rejectValue("pwd", "암호는 영소문자 또는 숫자이고 4자여야 합니다.");
				}
			}else if(upRegMode.equals("up")) {
				
				String pwd = dto.getPwd();
				
				// pwd가 null일 경우 길이 없는 문자를 삽입
				if(pwd==null) {
					pwd = "";
				}
				
				// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드를 호출하여
				// BoardDTO 객체의 속성변수명 pwd가 비거나 공백이면
				// 경고 메시지를 Errors 객체에 저장
				ValidationUtils.rejectIfEmptyOrWhitespace(
						
					// Errors 객체 선언
					errors
					
					// BoardDTO 객체의 속성변수명 선언
					, "pwd"
						
					// BoardDTO 객체의 속성변수명이
					// 비거나 공백일 경우 보낼 경고 문구 설정
					, "암호를 입력해주세요."
				);
			}

		} catch (Exception e) {
			System.out.println("BoardValidator.validate 메소드 실행 시 예외 발생!");
		}
	}


}
