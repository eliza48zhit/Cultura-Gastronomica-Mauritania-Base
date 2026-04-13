// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaMauritania
 * @dev Registro de tecnicas culinarias nomadas y gestion de recursos del desierto.
 * Serie: Sabores de Africa (20/54)
 * Hito: Primer tercio de la expedicion completado.
 */
contract CulturaMauritania {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 nivelGlucosaDatil;  // Escala de dulzor natural (1-10)
        uint256 humedadGrano;       // Control de hidratacion del cuscus (1-5)
        bool usaLecheCamella;       // Validador de lipidos del Sahara
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Registro inicial: Ingenieria de la energia en el desierto
        registrarPlato(
            "Cuscus de Datiles", 
            "Semola de trigo, datiles maduros, mantequilla clarificada.",
            "Hidratar el grano al vapor y mezclar con pasta de datiles para una integracion molecular del dulzor.",
            8, 
            3, 
            false
        );
    }

    /**
     * @dev Almacena un nuevo perfil culinario en la red Base.
     */
    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _glucosa, 
        uint256 _humedad,
        bool _camella
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_glucosa <= 10, "Escala glucosa: 1 a 10");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes, // Corregido: Coincide con el Struct
            preparacion: _preparacion,
            nivelGlucosaDatil: _glucosa,
            humedadGrano: _humedad,
            usaLecheCamella: _camella,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    /**
     * @dev Consulta tecnica de los parametros del plato.
     */
    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 glucosa,
        uint256 humedad,
        bool camella,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (
            p.nombre, 
            p.nivelGlucosaDatil, 
            p.humedadGrano, 
            p.usaLecheCamella, 
            p.likes
        );
    }
}
