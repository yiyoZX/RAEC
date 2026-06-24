const { expect } = require('chai');
const { By } = require('selenium-webdriver');
const { createDriver } = require('../helpers/driver');
const LoginPage = require('../pages/LoginPage');
const ActividadesPage = require('../pages/ActividadesPage');

describe('Módulo Actividades - RAEC', function () {
    this.timeout(120000);
    let driver, loginPage, actividadesPage;

    // ANTES de todas las pruebas: crear driver y hacer login
    before(async function () {
        driver = await createDriver();
        loginPage = new LoginPage(driver);
        actividadesPage = new ActividadesPage(driver);

        // Primero hacer login
        await loginPage.navigate();
        await loginPage.login('ana.fernandez@instituto4.cl', 'clave123');
        await driver.sleep(2000);
        const url = await loginPage.getCurrentUrl();
        expect(url).to.include('/dashboard');
    });

    // DESPUÉS de todas las pruebas: esperar para inspección visual y cerrar
    after(async function () {
        if (driver) {
            console.log('\n🔍 Navegador abierto para inspección visual. Se cerrará en 5 segundos...');
            await driver.sleep(5000);
            await driver.quit();
        }
    });

    // ANTES de cada prueba: navegar a la página de registrar
    beforeEach(async function () {
        await actividadesPage.navigate();
    });

    // --- CASO 1: La página de registrar carga correctamente ---
    it('debe mostrar el formulario de registrar actividad', async function () {
        const url = await actividadesPage.getCurrentUrl();
        expect(url).to.include('/registrar');
    });

    it('datos vacios', async function () {
        await actividadesPage.clickEnviar();
        await driver.sleep(1000);

        // Verificar si aparece una alerta de error o un mensaje en la página
        try {
            const alerta = await driver.switchTo().alert();
            const textoAlerta = await alerta.getText();
            console.log('Alerta recibida:', textoAlerta);
            await alerta.accept();
            // Si hay alerta, verificar que contiene algún texto
            expect(textoAlerta).to.be.a('string');
            expect(textoAlerta.length).to.be.greaterThan(0);
        } catch (e) {
            // Si no hay alerta, buscar mensaje de error en la página
            const error = await actividadesPage.getErrorMessage();
            expect(error).to.be.a('string');
            expect(error.length).to.be.greaterThan(0);
        }
    });

    it('debe mostrar error al subir un archivo incorrecto', async function () {

        await actividadesPage.setRut('21111111-1');
        await driver.sleep(500);

        // 2. Seleccionar tipo de actividad: académica
        await actividadesPage.setTipoActividad('academica');
        await driver.sleep(500);

        // 3. Seleccionar la primera actividad disponible del dropdown
        const actividadSeleccionada = await actividadesPage.seleccionarPrimeraActividad();
        console.log('Actividad seleccionada:', actividadSeleccionada);
        await driver.sleep(500);

        await actividadesPage.setHoras('4');
        await driver.sleep(500);

        // 5. Escribir descripción
        await actividadesPage.setDescripcion('Asistencia a congreso');
        await driver.sleep(500);

        // Localizar el input de tipo file
        const inputArchivo = await driver.findElement(By.css('input[type="file"]'));

        // Enviar un archivo incorrecto (por ejemplo un .txt en vez de .pdf)
        await inputArchivo.sendKeys('C:\\Users\\usuario\\Desktop\\TramaJson.txt');
        await driver.sleep(3000);

        // Verificar que aparece un error
        const error = await actividadesPage.getErrorMessage();
        expect(error).to.include('formato'); // o el mensaje que muestre tu app
    });

    it('debe rellenar el formulario y enviarlo erroneamente el rut', async function () {
        // 1. Escribir RUT
        await actividadesPage.setRut('21111111-9');
        await driver.sleep(500);

        // 2. Seleccionar tipo de actividad: académica
        await actividadesPage.setTipoActividad('academica');
        await driver.sleep(500);

        // 3. Seleccionar la primera actividad disponible del dropdown
        const actividadSeleccionada = await actividadesPage.seleccionarPrimeraActividad();
        console.log('Actividad seleccionada:', actividadSeleccionada);
        await driver.sleep(500);

        // 4. Escribir horas totales
        await actividadesPage.setHoras('10');
        await driver.sleep(500);

        // 5. Escribir descripción
        await actividadesPage.setDescripcion('Actividad de prueba automatizada con Selenium');
        await driver.sleep(500);

        // 6. Hacer clic en Enviar
        await actividadesPage.clickEnviar();
        await driver.sleep(1000);

        const error = await actividadesPage.getErrorMessage();
        expect(error).to.include('formato'); // o el mensaje que muestre tu app

    });

    // --- CASO 4: Rellenar y enviar el formulario correctamente ---
    it('debe rellenar el formulario y enviarlo exitosamente', async function () {
        // 1. Escribir RUT
        await actividadesPage.setRut('12345678-9');
        await driver.sleep(500);

        // 2. Seleccionar tipo de actividad: académica
        await actividadesPage.setTipoActividad('academica');
        await driver.sleep(500);

        // 3. Seleccionar la primera actividad disponible del dropdown
        const actividadSeleccionada = await actividadesPage.seleccionarPrimeraActividad();
        console.log('Actividad seleccionada:', actividadSeleccionada);
        await driver.sleep(500);

        // 4. Escribir horas totales
        await actividadesPage.setHoras('10');
        await driver.sleep(500);

        // 5. Escribir descripción
        await actividadesPage.setDescripcion('Actividad de prueba automatizada con Selenium');
        await driver.sleep(500);

        // 6. Hacer clic en Enviar
        await actividadesPage.clickEnviar();
        await driver.sleep(1000);

        // 7. Aceptar la alerta de éxito
        const alerta = await driver.switchTo().alert();
        const textoAlerta = await alerta.getText();
        console.log('Alerta recibida:', textoAlerta);
        await alerta.accept();

        // Verificar que la alerta confirma el guardado
        expect(textoAlerta).to.include('exitosamente');
    });
});