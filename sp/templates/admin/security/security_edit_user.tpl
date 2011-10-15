<h2><?=$s_edit_user;?></h2>

<div style="float:left;margin:10px;">

 <table  cellspacing="3"  border="0" >
 <tr bgcolor="#BDBDBD">
  <td> <?=$s_id;?>
   </td>
 <td><?=$s_login;?>
   </td>
   <td><?=$s_level;?>
   </td>
    <td>
   <?=$del;?>
   </td>
 </tr>
 <?=$tr_l;?>
 </table>
</div><br clear="all"/>

<fieldset>
    <legend><?=$s_add_user;?></legend>
    <table borser="0">

        <tr>
            <td>
        <form action="<?=$admin_dir_full;?>s_add_user/insert" method="post">
<?=$s_name;?>
        </td>
        <td> 
   <input name="name" type="text" value="">
   </td>
   <td>
       <?=$s_adress;?>
   </td>
   <td>
   <input name="adress" type="text" value="">
   </td>
 
        </tr>
        <tr>
            <td>
   <?=$s_pass;?>
                </td>
                <td>
   <input name="pass" type="text" value="">
   </td>
   <td>
   <?=$s_login;?>
       </td>
       <td>
   <select size="1" name="type">

  <?=$select_op;?>
</select>
           </td>
        
  
  
  
   

        </tr>
    </table>
    <br/>
     <input type="submit" value="<?=$send;?>">
      </form>
                </fieldset>
     <br/>          
     <fieldset>
     
         <legend><?=$s_add_login;?></legend><br/>  
<form name="" action="<?=$admin_dir_full;?>s_add_login" method="post">
                <table border="0">
                    <tr>
                        <td>
<?=$s_login;?></td>
                        <td>
  <input name="login" type="text" value=""></td>
                        <td>
<?=$s_level;?></td>
                        <td>
  <input name="level" type="text" value="1"> </td> 
  </tr>
   </table><br/>  
  <input type="submit" value="<?=$send;?>">
</form>
</fieldset>
                   
