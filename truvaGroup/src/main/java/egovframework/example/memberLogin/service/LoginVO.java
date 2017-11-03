package egovframework.example.memberLogin.service;

public class LoginVO {

	private static final long serialVersionUID = 1L;

	private String memberId = "";
	
	private String memberPw = "";
	
	private String memberMail = "";
	
	private String memberHpf;
	
	private String memberHpm;
	
	private String memberHpl;
	
	private String seq;

	private String memberName;
	
	private String memberNumber;
	
	
	public String getMemberNumber() {
		return memberNumber;
	}

	public void setMemberNumber(String memberNumber) {
		this.memberNumber = memberNumber;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
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
