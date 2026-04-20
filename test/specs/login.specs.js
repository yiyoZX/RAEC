const { expect } = require('chai');
const { createDriver } = require('../helpers/driver');
const LoginPage = require('../pages/LoginPage');
describe('Módulo Login - RAEC', function () {
    // Mocha necesita más tiempo porque Selenium es lento
    this.timeout(30000);
    let driver;
    let loginPage;
    // ANTES de todas las pruebas: crear el driver (abrir navegador)
    before(async function () {
        driver = await createDriver();
        loginPage = new LoginPage(driver);
    });
    // DESPUÉS de todas las pruebas: cerrar el navegador
    after(async function () {
        if (driver) {
            await driver.quit();
        }
    });
    // ANTES de cada prueba: navegar a la página de login
    beforeEach(async function () {
        await loginPage.navigate();
    });
    // --- CASO 1: La página carga correctamente ---
    it('debe mostrar el formulario de login', async function () {
        const url = await loginPage.getCurrentUrl();
        expect(url).to.include('/login');
    });
    // --- CASO 2: Login con credenciales incorrectas ---
    it('debe mostrar error con credenciales incorrectas', async function () {
        await loginPage.login('correo_falso@test.com', 'password_falso');
        const error = await loginPage.getErrorMessage();
        expect(error).to.be.a('string');
        expect(error.length).to.be.greaterThan(0);
    });
    // --- CASO 3: Botón "Ingresar como Estudiante" ---
    it('debe navegar al login de estudiante', async function () {
        await loginPage.clickEstudiante();
        // Esperar a que la URL cambie
        await driver.sleep(2000);
        const url = await loginPage.getCurrentUrl();
        expect(url).to.include('/loginStudent');
    });
    // --- CASO 4: Login exitoso (NECESITAS CREDENCIALES REALES) ---
    // Descomenta cuando tengas credenciales válidas

    it('debe redirigir al dashboard con credenciales válidas', async function () {
        await loginPage.login('ana.fernandez@instituto4.cl', 'clave123');
        // Esperar a que redirija
        await driver.sleep(3000);
        const url = await loginPage.getCurrentUrl();
        expect(url).to.include('/dashboard');
    });

});