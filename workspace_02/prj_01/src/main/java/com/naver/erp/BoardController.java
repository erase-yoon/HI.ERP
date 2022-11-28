package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {
	
	// boardDAO 속성변수에
	// BoardDAO 인터페이스를 구현한 클래스를 객체화 하여
	// 객체의 메모리 위치 주소 값을 저장한다.
	@Autowired
	private BoardDAO boardDAO;
	// Autowired로 [ = new ~;]을 생략하고 선언하면
	// BoardDAO 인터페이스를 구현할 클래스를 찾을 때(호출할 때?)
	// 그 클래스의 이름은 무엇이든 상관없다.
	// 단 BoardDAO 인터페이스를 구현한 클래스는 1개만 생성해야 한다.
	
	// boardService 속성변수에
	// BoardService 인터페이스를 구현한 클래스를 객체화 하여
	// 객체의 메모리 위치 주소 값을 저장한다.
	@Autowired
	private BoardService boardService;
	// Autowired로 [ = new ~;]을 생략하고 선언하면
	// BoardService 인터페이스를 구현할 클래스를 찾을 때(호출할 때?)
	// 그 클래스의 이름은 무엇이든 상관없다.
	// 단 BoardService 인터페이스를 구현한 클래스는 1개만 생성해야 한다.
	
	// ---------------------------------------------------------------
	// 가상주소 /boardList.do로 접근하면 호출되는 메소드 선언
	// @RequestMapping 내부에 method="RequestMethod.POST"가 없으므로
	// 가상주소 /boardList.do로 접근 시 get 또는 post 접근 모두 허용
	// ---------------------------------------------------------------
	@RequestMapping(value="/boardList.do")
	public ModelAndView boardListForm( 
			
			// 파라미터값을 저장할 [BoardSearchDTO 객체]를 매개변수로 선언
			BoardSearchDTO boardSearchDTO
			// [파라미터명]과 [BoardSearchDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
			
//			미 로그인 시 보여줄 창 띄우기(직접설정)
//			, HttpSession session
	) {
		
//		if(boardSearchDTO.getDate()!=null) {
//			for(int i=0; i<boardSearchDTO.getDate().size(); i++){
//				System.out.println(boardSearchDTO.getDate().get(i));
//			}
//		}
//		System.out.println("getKeyword1 : " + boardSearchDTO.getKeyword1());
//		System.out.println("getSelectPageNo : " + boardSearchDTO.getSelectPageNo());
//		System.out.println("getRowCntPerPage : " + boardSearchDTO.getRowCntPerPage());
//		System.out.println("getPageNoPerPage : " + boardSearchDTO.getPageNoPerPage());
		
//		미 로그인 시 보여줄 창 띄우기(직접설정)
//		String mid = (String)session.getAttribute("mid");
//		if(mid==null) {
//			ModelAndView mav = new ModelAndView();
//			
//			mav.addObject("msg", "로그인을 먼저 해주세요.");
//			mav.setViewName("error.jsp");
//			
//			return mav;
//		}
		
		// BoardDAOImpl 객체의 
		// getBoardListTotAllCnt 메소드 호출로 [게시판 행의 총 개수] 얻기
		int boardTotAllCnt = this.boardDAO.getBoardListTotAllCnt(boardSearchDTO);
		
		// BoardDAOImpl 객체의 
		// getBoardListTotCnt 메소드 호출로 [검색된 게시판 행의 개수] 얻기
		int boardTotCnt = this.boardDAO.getBoardListTotCnt(boardSearchDTO);
		
		// Util 객체의 
		// getPagingMap 메소드 호출로 
		// paging 처리와 관련된 데이터와
		// 기타 데이터가 저장되어 있는 HashMap 객체 얻기
			// 기타 데이터 : DB 연동 시 필요한 데이터, 보정된 선택 페이지 번호 등
		Map<String, Integer> pagingMap = Util.getPagingMap(
				
			// 선택된 페이지 번호
			boardSearchDTO.getSelectPageNo()
			
			// 한 화면에 보여지는 행의 개수
			, boardSearchDTO.getRowCntPerPage()
			
			// 검색된 게시판 행의 총 개수 
			, boardTotCnt
		);
		
		// boardSearchDTO 객체의 
		// setSelectPageNo 메소드 호출로 [선택된 페이지 번호] 보정
		boardSearchDTO.setSelectPageNo((int)pagingMap.get("selectPageNo"));
		
		// boardSearchDTO 객체의 
		// setBegin_rowNo 메소드 호출로 [보여지는 시작 페이지 번호] 보정
		boardSearchDTO.setBegin_rowNo((int)pagingMap.get("begin_rowNo"));
		
		// boardSearchDTO 객체의 
		// setEnd_rowNo 메소드 호출로 [보여지는 끝 페이지 번호] 보정
		boardSearchDTO.setEnd_rowNo((int)pagingMap.get("end_rowNo"));
		
		// BoardDAOImpl 객체의 
		// getBoardList 메소드 호출로 [게시판 목록] 얻기
		List<Map<String, String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);
		
		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]에 
		// [게시판 목록 검색 결과]를 저장
		mav.addObject("boardList", boardList);
		// [ModelAndView 객체]에 저장된 객체는
		// HttpServletRequest 객체에도 저장된다.
		
		// [ModelAndView 객체]에 
		// [게시판 목록 검색 결과 개수]를 저장
		mav.addObject("boardTotCnt", boardTotCnt);
		
		// [ModelAndView 객체]에 
		// [게시판 목록 검색 총 결과]를 저장
		mav.addObject("boardTotAllCnt", boardTotAllCnt);
		
		// [ModelAndView 객체]에 
		// [페이징 처리 관련 HashMap 객체]를 저장
		mav.addObject("pagingMap", pagingMap);
		
		// [ModelAndView 객체]에 
		// [보정된 선택 페이지 번호]를 저장
		 mav.addObject("selectPageNo", (int)pagingMap.get("selectPageNo"));
//		해당 코딩을 쓰지 않으면 boardList.jsp에서
//		formObj.find(".selectPageNo").val("${requestScope.selectPageNo}"); 대신
//		formObj.find(".selectPageNo").val("${requestScope.pagingMap.selectPageNo}"); 사용하여야 함


		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		// [호출할 JSP 페이지명] 앞, 뒤에 붙는 위치 경로 및 확장자는
		// application.properties에서 
		// spring.mvc.view.prefix=위치 경로
		// spring.mvc.view.suffix=확장자
		// 로 설정 가능하다.
		// <참고> 기본 저장 경로에서 webapp까지는 설정되어 있다.
		mav.setViewName("boardList.jsp");
		
		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}
	
	// ---------------------------------------------------------------
	// 가상주소 /boardRegForm.do로 접근하면 호출되는 메소드 선언
	// @RequestMapping 내부에 method="RequestMethod.POST"가 없으므로
	// 가상주소 /boardRegForm.do로 접근 시 get 또는 post 접근 모두 허용
	// ---------------------------------------------------------------
	@RequestMapping(value="/boardRegForm.do")
	public ModelAndView boardRegForm(){

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		// [호출할 JSP 페이지명] 앞, 뒤에 붙는 위치 경로 및 확장자는
		// application.properties에서 
		// spring.mvc.view.prefix=위치 경로
		// spring.mvc.view.suffix=확장자
		// 로 설정 가능하다.
		// <참고> 기본 저장 경로에서 webapp까지는 설정되어 있다.
		mav.setViewName("boardRegForm.jsp");

		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}
	
	// ---------------------------------------------------------------
	// /boardRegProc.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping( 
			value="/boardRegProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public Map<String, String> boardRegProc( 
			
			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
			
			// Error 객체를 관리하는 BindingResult 객체가 저장되어 들어오는
			// 매개변수 bindingResult 선언
			// 매개변수에 BindingResult 객체가 있을 경우
			// 내부에서 유효성 체크 코드가 실행된다.
			, BindingResult bindingResult
	){
		
		int boardRegCnt = 0;
		
		// 동료 메소드 check_BoardDTO를 호출하여
		// [유효성 체크] 후 경고 문자 얻기
		String msg = check_BoardDTO(boardDTO, bindingResult, "reg");
		
		// msg 변수에 ""가 저장되어 있을 경우
		// 유효성 체크가 성공했을 경우
		if(msg!=null && msg.equals("")) {
			
			// [boardServiceDAOImpl 객체]의 insertBoard 메소드를 호출하여 
			// 게시판 글을 입력하고 [입력이 적용될 행의 개수] 얻기
			boardRegCnt = this.boardService.insertBoard(boardDTO);
			
		}
		
		// 비동기 방식으로 접속하는 웹 브라우저에게 던져줄 
		// 데이터를 가진 HashMap 객체 생성
		// 웹 브라우저에서에서는 JSON 객체로 데이터를 저장한다.
			// -> HashMap 객체는 JSON 객체로 변화되어 웹 브라우저로 전송된다.
		Map<String, String> responseMap = new HashMap<String, String>();
		
		// HashMap 객체에 경고 문자 저장
		responseMap.put("msg", msg);
		
		// HashMap 객체에 [새 글 쓰기] 또는 [댓글 쓰기]할 경우
		// DB의 board 테이블에 입력이 성공된 행의 개수 저장
		responseMap.put("boardRegCnt", boardRegCnt + "");

		// [HashMap 객체] 리턴
		// 웹 브라우저에서에서는 JSON 객체로 데이터를 저장한다.
			// -> HashMap 객체는 JSON 객체로 변화되어 웹 브라우저로 전송된다.
		return responseMap;
	}
	
	// ---------------------------------------------------------------
	// /boardRegProc2.do로 접근하면 호출되는 메소드 선언 (유효성 체크 전)
	// ---------------------------------------------------------------
	@RequestMapping( 
			value="/boardRegProc2.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int boardRegProc2( 
			
			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
	){
		
		// [boardServiceDAOImpl 객체]의 insertBoard 메소드를 호출하여 
		// 게시판 글을 입력하고 [입력이 적용될 행의 개수] 얻기
		int boardRegCnt = this.boardService.insertBoard(boardDTO);
			
		// [입력 적용행의 개수] 얻기
		return boardRegCnt;
	}
	
	// ---------------------------------------------------------------
	// /boardDetailForm.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value="/boardDetailForm.do")
	public ModelAndView boardDetailForm(
			
		// "b_no"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 int b_no에 저장
		@RequestParam(value = "b_no") int b_no
		// 상세보기 할 게시판 고유번호가 들어오는 매개변수 선언
	){
		
		// [BoardServiceImpl 객체]의 getBoard 메소드를 호출하여 
		// [1개의 게시판 글]을 boardDTO 객체에 담아오기
		BoardDTO boardDTO = this.boardService.getBoard(b_no, true);
		// BoardDTO boardDTO를 BoardVO boardVO로도 사용
		// VO : Value Object
		// DTO : Data Transfer Object

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		mav.setViewName("boardDetailForm.jsp");
		
		// [ModelAndView 객체]에 1개의 게시판 글을 저장한
		// BoardDTO 객체 저장하기
		mav.addObject("boardDTO", boardDTO);

		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}
	
	// ---------------------------------------------------------------
	// /boardUpDelForm.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping(value="/boardUpDelForm.do")
	public ModelAndView boardUpDelForm(
			
		// "b_no"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 int b_no에 저장
		@RequestParam(value = "b_no") int b_no
		// 수정/삭제 할 게시판 고유번호가 들어오는 매개변수 선언
	){
		
		// [BoardServiceImpl 객체]의 getBoard 메소드를 호출하여 
		// [1개의 게시판 글]을 boardDTO 객체에 담아오기
		BoardDTO boardDTO = this.boardService.getBoard(b_no, false);
		// BoardDTO boardDTO를 BoardVO boardVO로도 사용
		// VO : Value Object
		// DTO : Data Transfer Object

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		mav.setViewName("boardUpDelForm.jsp");
		
		// [ModelAndView 객체]에 1개의 게시판 글을 저장한
		// BoardDTO 객체 저장하기
		mav.addObject("boardDTO", boardDTO);

		// [ModelAndView 객체] 리턴
		return mav;
		// Spring은 ModelAndView 객체 리턴 시
		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
	}
	
	// ---------------------------------------------------------------
	// /boardUpProc.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping( 
			value="/boardUpProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public Map<String, String> boardUpProc( 
			
			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
			
			// Error 객체를 관리하는 BindingResult 객체가 저장되어 들어오는
			// 매개변수 bindingResult 선언
			// 매개변수에 BindingResult 객체가 있을 경우
			// 내부에서 유효성 체크 코드가 실행된다.
			, BindingResult bindingResult
	){

		int boardUpCnt = 0;
		
		// 동료 메소드 check_BoardDTO를 호출하여
		// [유효성 체크] 후 경고 문자 얻기
		String msg = check_BoardDTO(boardDTO, bindingResult, "up");
		
		// msg 변수에 ""가 저장되어 있을 경우
		// 유효성 체크가 성공했을 경우
		if(msg!=null && msg.equals("")) {
			
			// [BoardDAOImpl 객체]의 updateBoard 메소드를 호출하여 
			// 게시판 글을 수정하고 [수정이 적용될 행의 개수] 얻기
			boardUpCnt = this.boardService.updateBoard(boardDTO);
			
		}
		
		// 비동기 방식으로 접속하는 웹 브라우저에게 던져줄 
		// 데이터를 가진 HashMap 객체 생성
		// 웹 브라우저에서에서는 JSON 객체로 데이터를 저장한다.
			// -> HashMap 객체는 JSON 객체로 변화되어 웹 브라우저로 전송된다.
		Map<String, String> responseMap = new HashMap<String, String>();
		
		// HashMap 객체에 경고 문자 저장
		responseMap.put("msg", msg);
		
		// HashMap 객체에 글을 수정할 경우
		// DB의 board 테이블에 갱신이 성공된 행의 개수 저장
		responseMap.put("boardUpCnt", boardUpCnt + "");

		// [HashMap 객체] 리턴
		// 웹 브라우저에서에서는 JSON 객체로 데이터를 저장한다.
			// -> HashMap 객체는 JSON 객체로 변화되어 웹 브라우저로 전송된다.
		return responseMap;
	}
	
	// ---------------------------------------------------------------
	// /boardUpProc2.do로 접근하면 호출되는 메소드 선언 (유효성 체크 전)
	// ---------------------------------------------------------------
	@RequestMapping( 
			value="/boardUpProc2.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int boardUpProc2( 
			
			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
	){
		// [BoardDAOImpl 객체]의 updateBoard 메소드를 호출하여 
		// 게시판 글을 수정하고 [수정이 적용될 행의 개수] 얻기
		int updateBoardCnt = this.boardService.updateBoard(boardDTO);
		
		// [수정 적용행의 개수] 얻기
		return updateBoardCnt;
	}
	
	// ---------------------------------------------------------------
	// /boardDelProc.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	@RequestMapping( 
			value="/boardDelProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int boardDelProc( 
			
			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
			BoardDTO boardDTO
			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
	){
		// [BoardDAOImpl 객체]의 updateBoard 메소드를 호출하여 
		// 게시판 글을 삭제하고 [삭제가 적용될 행의 개수] 얻기
		int deleteBoardCnt = this.boardService.deleteBoard(boardDTO);
		
		// [삭제 적용행의 개수] 얻기
		return deleteBoardCnt;
	}
	
	// 게시판 입력, 수정 시 입력된 데이터의 유효성을 검사하고
	// 유효성 검사에 위배되면 경고 문자를 리턴하는 메소드 선언
	public String check_BoardDTO(BoardDTO boardDTO, BindingResult bindingResult, String upRegMode) {
		
		String msg = "";
		
		// BoardDTO 객체에 저장된 데이터의 유효성 체크할 BoardValidator 객체 생성
		// BoardValidator 객체의 validate 메소드 호출하여 유효성 체크 실행
		BoardValidator boardValidator = new BoardValidator(upRegMode);
		boardValidator.validate(
				
				// 유효성 체크를 진행할 DTO 객체 선언
				boardDTO
				
				// 유효성 체크 결과를 관리하는 BindingResult 객체 선언
				, bindingResult
		);
		
		// bindingResult.hasErrors() 메소드의 결과값이 true일 경우
		if(bindingResult.hasErrors()) {
			
			// BoardValidator 객체에 저장된 경고 문구를 얻어 msg 변수에 저장
			msg = bindingResult.getFieldError().getCode();
			
		}
		
		// msg 변수 안의 문자 리턴
		return msg;
	}
	
//	// ---------------------------------------------------------------
//	// 가상주소 /boardReplyForm.do로 접근하면 호출되는 메소드 선언
//	// @RequestMapping 내부에 method="RequestMethod.POST"가 없으므로
//	// 가상주소 /boardReplyForm.do로 접근 시 get 또는 post 접근 모두 허용
//	// ---------------------------------------------------------------
//	@RequestMapping(value="/boardReplyForm.do")
//	public ModelAndView boardReplyForm(
//			
//		// "b_no"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 int b_no에 저장
//		@RequestParam(value = "b_no") int b_no
//		// 답글을 달 게시판 고유번호가 들어오는 매개변수 선언
//			
//	){
//		
//		// [BoardServiceImpl 객체]의 getBoard 메소드를 호출하여 
//		// [1개의 게시판 글]을 boardDTO 객체에 담아오기
//		BoardDTO boardDTO = this.boardService.getBoard(b_no, false);
//		// BoardDTO boardDTO를 BoardVO boardVO로도 사용
//		// VO : Value Object
//		// DTO : Data Transfer Object
//
//		// [ModelAndView 객체] 생성
//		ModelAndView mav = new ModelAndView();
//		
//		// [ModelAndView 객체]의
//		// setViewName 메소드를 호출하여
//		// [호출할 JSP 페이지명]을 문자로 저장
//		mav.setViewName("boardReplyForm.jsp");
//		
//		// [ModelAndView 객체]에 1개의 게시판 글을 저장한
//		// BoardDTO 객체 저장하기
//		mav.addObject("boardDTO", boardDTO);
//		
//		// [ModelAndView 객체] 리턴
//		return mav;
//		// Spring은 ModelAndView 객체 리턴 시
//		// 저장된 [JSP 페이지명]에 있는 [JSP 페이지]를 호출한다.
//	}
//		
//	// ---------------------------------------------------------------
//	// /boardReplyRegProc.do로 접근하면 호출되는 메소드 선언
//	// ---------------------------------------------------------------
//	@RequestMapping( 
//			value="/boardReplyRegProc.do" 
//			,method=RequestMethod.POST
//			,produces="application/json;charset=UTF-8"
//	)
//	@ResponseBody
//	public int boardReplyRegProc( 
//			
//			// 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
//			BoardDTO boardDTO
//			// [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같을 경우
//			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
//	){
//		
//		this.boardDAO.updatePrintNo(boardDTO.getB_no());
//		
//		// [BoardDAOImpl 객체]의 insertReplyBoard 메소드를 호출하여 
//		// 게시판 글을 입력하고 [입력이 적용될 행의 개수] 얻기
//		int boardReplyRegCnt = this.boardDAO.insertReplyBoard(boardDTO);
//		
//		// [입력 적용행의 개수] 얻기
//		return boardReplyRegCnt;
//	}
	
}
