var req;

function loadXMLDoc(url,data) {
    // branch for native XMLHttpRequest object
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
        req.open("POST", url, true);
        req.onreadystatechange = processReqChange;
        req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        req.onreadystatechange = processReqChange;
        req.send("q="+data);
    // branch for IE/Windows ActiveX version
    } else if (window.ActiveXObject) {
        req = new ActiveXObject("Microsoft.XMLHTTP");
        if (req) {
            req.open("POST", url, true);
            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            req.onreadystatechange = processReqChange;
            req.send("q="+data);
        }
    }
}

function processReqChange(){
    if (req.readyState == 4) {
        if(req.status == 200) {
            if(req.responseText=="error")alert("<?=$erajaxside;?>");
            else
                ob=window.document.getElementById("sel");
            clearSelect(ob);
            //req.responseText;
            if(req.responseText=="erorr"){
                alert("<?=$erajax;?>");
                return false;
            }
            var arr = req.responseText.split("\n");
            //�������� � ���������� ���������...
            for (var i=0,len=arr.length;i<len;i++) {
                if(isNaN(arr[i])) addOption(ob, arr[i], arr[i], true);

            }
        }
    }

}

function addOption (oListbox, text, value, isDefaultSelected, isSelected)
{
    var oOption = document.createElement("option");
    oOption.appendChild(document.createTextNode(text));
    oOption.setAttribute("value", value);

    if (isDefaultSelected) oOption.defaultSelected = true;
    else if (isSelected) oOption.selected = true;

    oListbox.appendChild(oOption);
}



function chechk(ob){
    loadXMLDoc("returnside",ob.value);
    return;
}

function clearSelect(oListbox)
{
    for (var i=oListbox.options.length-1; i >= 0; i--)
    {
        oListbox.remove(i);
    }
}

function langCh(ob,id,order,vector,pag,search,mod_order){
    document.location.href = admin_dir_js+"id/"+id+"/"+ob.options[ob.selectedIndex].value+"/"+order+"/"+vector+"/"+pag+"/"+search+"/"+mod_order;
}

function langCh2(ob,id,order,vector,pag,search,lang){
    document.location.href = admin_dir_js+"id/"+id+"/"+lang+"/"+order+"/"+vector+"/"+pag+"/"+search+"/"+ob.options[ob.selectedIndex].value;
}

//jquery
$(document).ready(function(){ //start
    //ssideadd
    $("#ssideadd").click(function(){
        var str = $("form[name=name_addin]").serialize();
        $.ajax({
            url:admin_dir_js+'ajaxloadside',
            dataType: "html",
            type: "POST",
            data: str,
            success: function(html){
                $("#curside").html(html);
            }
        });
    });//end click

});

function click_check(ob){
    if($(ob).attr("checked")){

        $('input[name=add_in]').attr("readonly",true);
    }else{
        $('input[name=add_in]').removeAttr("readonly");
    }

}


function startUpdate(urlUpd,urlsite,version){

    $.ajax({
        dataType: "jsonp",
        url: urlUpd,
        type: "GET",
        data: {
            "urlsite":urlsite,
            "version":version
        },
        success:function(json){
            proxy(json);

        }
    });

}
function proxy(json){
    $.ajax({
        url: admin_dir_js+"proxy",
        type: "GET",
        data: {
            "json":json
        }

    });
}
 
$(document).ready(function(){

    // проверяем, есть ли на странице таблицы с классом table3

    if( $('table.table3').length > 0){

        // присваиваю для первого и последнего ряда таблицы несуществующие классы trfirst и trlast

        // для того чтобы при раскрашивании рядов не трогать первый и последний ряд

        $('table.table3 > tbody > tr:first-child').addClass('trfirst');
        $('table.table3 > tbody > tr:last-child').addClass('trlast');

   
        // увеличение высоты заглавного ряда, так надо по дизайну

        $('table.table3 > tbody > tr:first-child').css('height', "42px");
    
        // далее идет присвоение фоновых картинок  
        // фоновая картинка для левого и правого края

        $('table.table3 > tbody > tr > td:first-child').css('background', "url('/templates/images/t_lr.jpg') left top repeat-y");

        $('table.table3 > tbody > tr > td:last-child').css('background', "url('/templates/images/t_lr.jpg') right top repeat-y");
        // для верхнего ряда

        $('table.table3 > tbody > tr:first-child > td').css('background', "url('/templates/images/t_top.jpg') top repeat-x");
        // для нижнего ряда

        $('table.table3 > tbody > tr:last-child > td').css('background', "url('/templates/images/t_bottom.jpg') top repeat-x");
        // верхний левый угол

        $('table.table3 > tbody > tr:first-child > td:first-child').css('background', "url('/templates/images/t_top_left.gif') left top no-repeat");
        // верхний правый угол

        $('table.table3 > tbody > tr:first-child > td:last-child').css('background', "url('/templates/images/t_top_right.gif') right top no-repeat");
        // нижний левый угол

        $('table.table3 > tbody > tr:last-child > td:first-child').css('background', "url('/templates/images/t_bottom_left.gif') left top no-repeat");
        //нижний правый угод

        $('table.table3 > tbody > tr:last-child > td:last-child').css('background', "url('/templates/images/t_bottom_right.gif') right top no-repeat");

 

        // раскрашивание зеброй ячейки рядов таблицы за исключением первого и последнего рядов

        $('table.table3 > tbody > tr:even').filter(':not(.trfirst)').filter(':not(.trlast)').children().css('background-color', '#EEEEEE');

    }
    
    $(".spans").toggle(function() {
        $(this).next().slideToggle('slow');
    }, function() {
        $(this).next().slideToggle('slow');
    });
    
    
});






