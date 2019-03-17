({
    handleClick : function(component , event , helper){
        var actionName = event.getSource().get("v.label");
        if(actionName == "Refresh"){
            this.popolateProductData(component , event , helper)
        }
    },
    popolateProductData : function(component , event , helper){
        var action = component.get("c.getProductsData");
        action.setParams({
            "recordId": component.get("v.recordId") 
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.productData",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})