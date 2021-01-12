#include <OrderedAssociativeArray>

class Loadout {
    name := ""
    items := new OrderedAssociativeArray()

    __New(name := "", items := "") {
        this.name := name
        this.items := items
    }
}