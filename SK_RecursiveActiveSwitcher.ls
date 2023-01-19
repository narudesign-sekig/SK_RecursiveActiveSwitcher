@version 2.7
@warnings
@script generic
@name SK_RecursiveActiveSwitcher

var scene = Scene();

generic
{
    reqbegin("SK_RecursiveActiveSwitcher");
    reqsize(320, 100);

    ctl = ctlchoice("Items will be", 1, @"Inactive", "Active"@);
    ctlposition(ctl, 70, 30);

    return if !reqpost();

    var val = getvalue(ctl) - 1;

    reqend();
    
    var objects = scene.getSelect();
    
    // Recursive Selected Items
    
    for (n = 1; n <= size(objects); n++)
    {
        SelectedItemRecursive(objects[n], val);
    }
    
    // Restore Item Selection
    
    SelectItem(objects[1].id);
    for (n = 2; n <= size(objects); n++)
    {
        AddToSelection(objects[n].id);
    }
}

SelectedItemRecursive: obj, val
{
    if (obj == nill) return;
    
    SelectItem(obj.id);
    ItemActive(val);
    
    objChild = obj.firstChild();
    while (objChild != nill)
    {
        SelectedItemRecursive(objChild, val);
        objChild = obj.nextChild();
    }
}

