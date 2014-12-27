$(document).ready ->
    changelunchbox()
    cal()
    return
    

cal = ->
    selected = document.getElementById("order_lunchbox_id")
    lbox_id = selected.options.selectedIndex
    rate = 1.5 if lbox_id is 0
    rate = 1.0 if lbox_id is 1
    rate = 0.5 if lbox_id is 2
   
    
    div_price = document.getElementById("price")
    price = div_price.getAttribute('data-price')
    cal_price = price * rate
    p_price = document.createTextNode("#{cal_price}円")
    div_price.removeChild(div_price.childNodes.item(0)); 
    div_price.appendChild(p_price)
    
    
    
    div_kcal = document.getElementById("kcal")
    kcal = div_kcal.getAttribute('data-kcal')
    cal_kcal = kcal *rate
    p_kcal = document.createTextNode("#{cal_kcal}kcal")
    div_kcal.removeChild(div_kcal.childNodes.item(0)); 
    div_kcal.appendChild(p_kcal)
    return
    
changelunchbox = ->
    selected = document.getElementById("order_lunchbox_id")
    selected.addEventListener('change',cal,false)
    return
    