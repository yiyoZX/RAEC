const { By, until } = require('selenium-webdriver');

class ActividadesPage {
    constructor(driver) {
        this.driver = driver;
        this.url = 'http://localhost:3001/registrar';

        // Localizadores — sacados de FormularioActividad.jsx
        this.inputRut = By.id('rut');
        this.radioAcademica = By.css('input[name="academica"][value="1"]');
        this.radioNoAcademica = By.css('input[name="academica"][value="2"]');
        this.selectActividad = By.id('actividad');
        this.inputHoras = By.id('horas_totales');
        this.textareaDescripcion = By.id('about');
        this.btnEnviar = By.css('button[type="submit"]');
        this.btnLimpiar = By.css('button[type="button"]');
        this.errorMsg = By.css('.text-red-500');
    }

    // --- Acciones ---

    // Navegar a la página de registrar actividad
    async navigate() {
        await this.driver.get(this.url);
        // Esperar hasta que el campo RUT aparezca (máx 10 seg)
        await this.driver.wait(until.elementLocated(this.inputRut), 10000);
    }

    // Escribir RUT
    async setRut(rut) {
        const input = await this.driver.findElement(this.inputRut);
        await input.clear();
        await input.sendKeys(rut);
    }

    // Seleccionar tipo: 'academica' o 'no_academica'
    async setTipoActividad(tipo) {
        if (tipo === 'academica') {
            const radio = await this.driver.findElement(this.radioAcademica);
            await radio.click();
        } else {
            const radio = await this.driver.findElement(this.radioNoAcademica);
            await radio.click();
        }
    }

    // Seleccionar actividad del dropdown (espera a que se carguen las opciones)
    async setActividad(valor) {
        const select = await this.driver.findElement(this.selectActividad);
        // Esperar a que haya opciones cargadas del backend
        await this.driver.sleep(1000);
        const opcion = await select.findElement(By.css(`option[value="${valor}"]`));
        await opcion.click();
    }

    // Seleccionar la primera actividad disponible en el dropdown
    async seleccionarPrimeraActividad() {
        const select = await this.driver.findElement(this.selectActividad);
        await this.driver.sleep(1000);
        // Buscar la segunda opción (la primera es el placeholder "Seleccione una actividad")
        const opciones = await select.findElements(By.css('option'));
        if (opciones.length > 1) {
            await opciones[1].click();
            return await opciones[1].getText();
        }
        return null;
    }

    // Escribir horas totales
    async setHoras(horas) {
        const input = await this.driver.findElement(this.inputHoras);
        await input.clear();
        await input.sendKeys(horas);
    }

    // Escribir descripción
    async setDescripcion(texto) {
        const textarea = await this.driver.findElement(this.textareaDescripcion);
        await textarea.clear();
        await textarea.sendKeys(texto);
    }

    // Hacer clic en "Enviar Registro"
    async clickEnviar() {
        const btn = await this.driver.findElement(this.btnEnviar);
        await btn.click();
    }

    // Hacer clic en "Limpiar Formulario"
    async clickLimpiar() {
        const btn = await this.driver.findElement(this.btnLimpiar);
        await btn.click();
    }

    // Obtener mensaje de error si existe
    async getErrorMessage() {
        await this.driver.wait(until.elementLocated(this.errorMsg), 5000);
        const element = await this.driver.findElement(this.errorMsg);
        return await element.getText();
    }

    // Obtener la URL actual
    async getCurrentUrl() {
        return await this.driver.getCurrentUrl();
    }

    // Obtener el valor actual de un campo
    async getValorCampo(id) {
        const element = await this.driver.findElement(By.id(id));
        return await element.getAttribute('value');
    }
}

module.exports = ActividadesPage;
