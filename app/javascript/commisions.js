function calcCommisions (){
  const price = document.getElementById("item-price");
  price.addEventListener("input", ()=> {
    const salesCommisions = price.value * 0.1;
    const floorCommisions = Math.floor(salesCommisions);
    const salesGains = price.value - floorCommisions;
    const AddTaxPrice = document.getElementById("add-tax-price");
    AddTaxPrice.innerHTML = `${floorCommisions}`;
    const profit = document.getElementById("profit")
    profit.innerHTML = `${salesGains}`;
  });
}
window.addEventListener('load', calcCommisions); 