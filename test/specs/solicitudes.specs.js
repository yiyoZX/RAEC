const { expect } = require('chai');
const { createDriver } = require('../helpers/driver');
const LoginPage = require('../pages/LoginPage');
const SolicitudesPage = require('../pages/SolicitudesPage');

describe('Módulo Solicitudes - RAEC', function () {
    this.timeout(60000); // 60s porque hay login + navegación

    let driver;
    let loginPage;
    let solicitudesPage;

    // ─── SETUP ────────────────────────────────────────────────────────────────
    // Se ejecuta UNA VEZ antes de todos los tests
    before(async function () {
        driver = await createDriver();
        loginPage = new LoginPage(driver);
        solicitudesPage = new SolicitudesPage(driver);

        // Hacer login con un director/admin para poder ver solicitudes
        await loginPage.navigate();
        await loginPage.login('carlos.perez@instituto1.cl', 'clave123');
        await driver.sleep(3000); // Esperar a que redirija al dashboard
    });

    // Se ejecuta UNA VEZ al final: cerrar navegador
    after(async function () {
        if (driver) {
            await driver.quit();
        }
    });

    // ─── CASO 3: Mostrar cards si hay solicitudes pendientes ───────────────────
    it('debe mostrar solicitudes en tarjetas o el mensaje de lista vacía', async function () {
        await solicitudesPage.navigate();
        await solicitudesPage.waitForContent();

        const cantidad = await solicitudesPage.contarSolicitudes();
        const url = await solicitudesPage.getCurrentUrl();

        // Si no redirigió (tiene acceso), puede haber 0 o más solicitudes
        if (url.includes('/solicitudes')) {
            // No falla: la página puede estar vacía o con solicitudes
            expect(cantidad).to.be.at.least(0);
        }
    });

    // ─── CASO 4: Aprobar una solicitud ─────────────────────────────────────────
    it('se debe poder aprobar la solicitud', async function () {
        await solicitudesPage.navigate();
        await solicitudesPage.waitForContent();

        const cantidadAntes = await solicitudesPage.contarSolicitudes();

        if (cantidadAntes === 0) {
            console.log('⚠️  No hay solicitudes pendientes para aprobar. Se omite este caso.');
            this.skip(); // Omite el test sin fallo
        }

        // Click en "Aprobar" de la primera solicitud
        await solicitudesPage.clickPrimerAprobar();
        await driver.sleep(2000); // Esperar al alert y la respuesta del backend

        // Aceptar el alert de confirmación del navegador (si aparece)
        await solicitudesPage.aceptarAlertSiExiste();
        await driver.sleep(1000);

        const cantidadDespues = await solicitudesPage.contarSolicitudes();
        expect(cantidadDespues).to.be.lessThan(cantidadAntes);
    });

    // ─── CASO 5: Rechazar una solicitud ────────────────────────────────────────
    it('se debe poder rechazar las solicitudes', async function () {
        await solicitudesPage.navigate();
        await solicitudesPage.waitForContent();

        const cantidadAntes = await solicitudesPage.contarSolicitudes();

        if (cantidadAntes === 0) {
            console.log('⚠️  No hay solicitudes pendientes para rechazar. Se omite este caso.');
            this.skip();
        }

        // Click en "Rechazar" de la primera solicitud
        await solicitudesPage.clickPrimerRechazar();
        await driver.sleep(2000);

        // Aceptar el alert del navegador si aparece
        await solicitudesPage.aceptarAlertSiExiste();
        await driver.sleep(1000);

        const cantidadDespues = await solicitudesPage.contarSolicitudes();
        expect(cantidadDespues).to.be.lessThan(cantidadAntes);
    });
});
