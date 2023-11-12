class GameAddon {
    id := ""
    name := ""
    enabled := false

    __New(id, name, enabled := false) {
        this.id := id
        this.name := name
        this.enabled := enabled
    }
}