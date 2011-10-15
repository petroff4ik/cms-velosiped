<?
class MyValidator extends CustomValidator
{

    function DoValidate(&$formars,&$error_hash)
    {
        if(!empty($formars['cap']))
        {
            if($_SESSION['captcha']==$formars['cap']){
            		return true;
            		}else{            		$error_hash['cap']=E_VAL_NEELMNT_cap2;
        	  		return false;
            		}
        	}else{        	 $error_hash['cap']=E_VAL_NEELMNT_cap;        	  return false;
        	}

    }
}
?>