/******************************************
 * 정규표현식
 ******************************************/
var CommonJsUtil = 
{
	// 빈값 체크
    isEmpty : function(val) {
        if (null == val || null === val || "" == val || val == undefined || typeof(val) == undefined || "undefined" == val || "NaN" == val) {
            return true;
        } else {
            return false;
        }
    },
    
    isNumeric : function(val) {
    	if (!/^[0-9]+$/.test(val)) {
            return false;
        } else {
            return true;
        }
    },

    /* 한글 양식 체크*/
    isKor : function(val) {
    	if (!/([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/.test(val)) {
            return true;
        } else {
            return false;
        }
    },
    
    /* 빈값 지우기 */
    trim : function(target){
    	
    	var val = target.val().replace(/^\s*/,'').replace(/\s/g,'');
    	
    	return val;
    },
    
    /* 이메일 양식 체크 */
    isMail : function(val) {
    	
    	if (/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/.test(val)) {
			
    		return true;
		} else {
		
			 return false;
		}
    },
    
    /* 핸드폰번호 양식 변경 */
    phonRes : function (num){
        
        var phoneNum = "";
        
        if(num.length==11){
        	
            	phoneNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
        }else if(num.length == 10){
        	
        	phoneNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
        }else{
        	
            if(num.indexOf('02') == 0){
            	
            	phoneNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
            }else{
                	
            	phoneNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
            }
        }
        return phoneNum;
    }
}
/*
{

if( L_szKor < 2 || L_szKor > 6 )

{

alert("2~6글자만 입력할수 있습니다.");

frm.szKor.value="";

frm.szKor.focus();

return false;

}

}

}*/