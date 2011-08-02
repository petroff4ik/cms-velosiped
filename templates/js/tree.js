function show(id){  idi=id;
  id="b"+id;
 if(document.getElementById(id).style.display=="block"){

 	 document.getElementById(id).style.display="none";
                  document.getElementById(idi+"i").src="/templates/images/kr.jpg";
 	}else if(document.getElementById(id).style.display=="none"){

 		   document.getElementById(id).style.display="block";
           document.getElementById(idi+"i").src="/templates/images/krd.jpg";
 		};

}