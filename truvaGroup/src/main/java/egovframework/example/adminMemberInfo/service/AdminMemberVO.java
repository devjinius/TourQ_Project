package egovframework.example.adminMemberInfo.service;

public class AdminMemberVO {

	private static final long serialVersionUID = 1L;

	private String memberId = "";
	
	private String memberPw = "";
	
	private String memberMail = "";
	
	private String memberHpf;
	
	private String memberHpm;
	
	private String memberHpl;
	
	private String seq;

	private String rows = "";
	
	private String page = "";
	
	private String searchId = "";
	
	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public String getSearchId() {
		return searchId;
	}

	public void setSearchId(String searchId) {
		this.searchId = searchId;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public String getMemberMail() {
		return memberMail;
	}

	public void setMemberMail(String memberMail) {
		this.memberMail = memberMail;
	}

	public String getMemberHpf() {
		return memberHpf;
	}

	public void setMemberHpf(String memberHpf) {
		this.memberHpf = memberHpf;
	}

	public String getMemberHpm() {
		return memberHpm;
	}

	public void setMemberHpm(String memberHpm) {
		this.memberHpm = memberHpm;
	}

	public String getMemberHpl() {
		return memberHpl;
	}

	public void setMemberHpl(String memberHpl) {
		this.memberHpl = memberHpl;
	}
	
}
