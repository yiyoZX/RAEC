const { By, until } = require('selenium-webdriver');

class LoginPage {
    constructor(driver) {
        this.driver = driver;
        this.url = 'http://localhost:3001/login';


        // Localizadores — sacados de tu LoginPage.jsx
        // (id="correo", id="password", button type="submit", etc.)

        this.inputCorreo = By.id('correo');
        this.inputPassword = By.id('password');
        this.btnIngresar = By.css('button[type="submit"]');
        this.errorMsg = By.css('.text-red-600');
        this.btnEstudiante = By.xpath("//button[contains(text(), 'Estudiante')]");

    }


    // --- Acciones ---

    // Navegar a la página de login
    async navigate() {
        await this.driver.get(this.url);
        // Esperar hasta que el input de correo aparezca (máx 10 seg)
        await this.driver.wait(until.elementLocated(this.inputCorreo), 10000);
    }

    // Escribir en el campo correo
    async setCorreo(correo) {
        const input = await this.driver.findElement(this.inputCorreo);
        await input.clear();
        await input.sendKeys(correo);
    }

    // Escribir en el campo contraseña
    async setPassword(password) {
        const input = await this.driver.findElement(this.inputPassword);
        await input.clear();
        await input.sendKeys(password);
    }

    // Hacer clic en "Ingresar"
    async clickIngresar() {
        const btn = await this.driver.findElement(this.btnIngresar);
        await btn.click();
    }

    // Hacer login completo (combinación de las 3 acciones anteriores)
    async login(correo, password) {
        await this.setCorreo(correo);
        await this.setPassword(password);
        await this.clickIngresar();
    }

    // Obtener el texto del mensaje de error (si existe)
    async getErrorMessage() {
        // Esperar hasta que aparezca el mensaje de error
        await this.driver.wait(until.elementLocated(this.errorMsg), 10000);
        const element = await this.driver.findElement(this.errorMsg);
        return await element.getText();
    }

    // Hacer clic en el botón "Estudiante"
    async clickEstudiante() {
        const btn = await this.driver.findElement(this.btnEstudiante);
        await btn.click();
    }

    // Obtener la URL actual del navegador
    async getCurrentUrl() {
        return await this.driver.getCurrentUrl();
    }
}

module.exports = LoginPage;
