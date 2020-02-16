export function bgData() {
    return [
        bg("AuZtralia", 2, "J"),
        bg("Battlestar Galactica", 3, "J"),
        bg("Black Orchestra", 3, "J"),
        bg("Bloodbourne", 1, "J"),
        bg("Chaos Marauders", 1, "J"),
        bg("Chinatown", 2, "A"),
        bg("Concordia", 4, "J"),
        bg("Dark Souls", 2, "M"),
        bg("Deep Sea Adventure", 1, "A"),
        bg("Eclipse", 4, "A"),
        bg("Escape the Dark Castle", 1, "J"),
        bg("Fallen Land", 2, "J"),
        bg("Fortress America", 3, "J"),
        bg("Imperial Assault", 4, "J"),
        bg("Legendary Encounters: Alien", 3, "J"),
        bg("Lord of the Rings", 2, "J"),
        bg("Lord of the Rings: Journeys in Middle-earth", 3, "J"),
        bg("Lowlands", 3, "J"),
        bg("Mansions of Madness", 3, "J"),
        // bg("MaM", 2, "J"),
        bg("Oceans", 3, "A"),
        bg("On Mars", 5, "A"),
        bg("Parks", 2, "A"),
        bg("Puerto Rico", 3, "T", true),
        bg("Root", 4, "A"),
        bg("Secret Hitler", 1, "J"),
        bg("Scythe", 4, "J"),
        bg("Startups", 1, "A"),
        bg("Terraforming Mars", 3, "T"),
        bg("Underwater Cities", 4, "A")
    ]
}

function bg(name, complexity, owner, isBlacklisted = false) {
    return {
        "name": name,
        "complexity": complexity,
        "owner": owner,
        "isBlacklisted": isBlacklisted
    }
}