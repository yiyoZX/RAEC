const { By, until } = require('selenium-webdriver');

class SolicitudesPage {
    constructor(driver) {
        this.driver = driver;
        this.url = 'http://localhost:3001/solicitudes';

        // Localizadores de la página de solicitudes
        this.tituloPage    = By.css('h2');
        this.cardSolicitud = By.css('.bg-white.rounded-lg.shadow-lg');
        this.btnAprobar    = By.xpath("//button[contains(text(), 'Aprobar')]");
        this.btnRechazar   = By.xpath("//button[contains(text(), 'Rechazar')]");
        this.mensajeVacio  = By.xpath("//*[contains(text(), 'No hay solicitudes pendientes')]");
    }

    // Navegar directo a solicitudes (asume que ya hay sesión activa)
    async navigate() {
        await this.driver.get(this.url);
        await this.driver.sleep(2000);
    }

    // Obtener la URL actual
    async getCurrentUrl() {
        return await this.driver.getCurrentUrl();
    }

    // Esperar hasta que las cards carguen (o el mensaje "no hay solicitudes")
    async waitForContent() {
        await this.driver.wait(async () => {
            const cards = await this.driver.findElements(this.cardSolicitud);
            const vacio = await this.driver.findElements(this.mensajeVacio);
            return cards.length > 0 || vacio.length > 0;
        }, 10000, 'La página de solicitudes no cargó en 10 segundos');
    }

    // Contar cuántas solicitudes hay en la página actual
    async contarSolicitudes() {
        const cards = await this.driver.findElements(this.cardSolicitud);
        return cards.length;
    }

    // Obtener la primera tarjeta de solicitud
    async getPrimeraSolicitud() {
        const cards = await this.driver.findElements(this.cardSolicitud);
        if (cards.length === 0) return null;
        return cards[0];
    }

    // Click en el primer botón "Aprobar" visible
    async clickPrimerAprobar() {
        const botones = await this.driver.findElements(this.btnAprobar);
        if (botones.length === 0) throw new Error('No hay botones de Aprobar visibles');
        await botones[0].click();
    }

    // Click en el primer botón "Rechazar" visible
    async clickPrimerRechazar() {
        const botones = await this.driver.findElements(this.btnRechazar);
        if (botones.length === 0) throw new Error('No hay botones de Rechazar visibles');
        await botones[0].click();
    }

    // Leer el texto del título h2
    async getTitulo() {
        await this.driver.wait(until.elementLocated(this.tituloPage), 10000);
        const el = await this.driver.findElement(this.tituloPage);
        return await el.getText();
    }

    // Verificar si hay un alert/dialog del navegador y aceptarlo
    async aceptarAlertSiExiste() {
        try {
            const alert = await this.driver.switchTo().alert();
            const texto = await alert.getText();
            await alert.accept();
            return texto;
        } catch {
            return null; // No había alert
        }
    }
}

module.exports = SolicitudesPage;
