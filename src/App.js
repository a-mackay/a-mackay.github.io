import React from 'react';
import './App.css';
import { bgData } from "./Bgs.js";


function App() {
    return (
        <div className="App">
            <div className="SplitPane">
                <NavPane></NavPane>
                <div className="RightPane">
                    <BgTable/>
                </div>
            </div>
        </div>
    );
}

function NavPane() {
    return <div className="NavPane">Hi</div>
}

function BgTable() {
    let bgs = bgData();

    return (
        <table className="BgTable">
            <tr>
                <th>Boardgame</th>
                <th>Weight</th>
            </tr>
            {bgs.map((bg, index) => BgRow(bg, index % 2 === 0))}
        </table>
    )
}

function BgRow(bg, isOddRow) {
    let className = isOddRow ? "OddTableRow" : "EvenTableRow";
    return (
        <tr className={className}>
            <td>{bg.name}</td>
            <td>{Icons(bg.complexity)}</td>
        </tr>
    )
}

function Icons(complexity) {
    var imageClassName;
    var imageCount;
    var title;
    let brain = "Brain";
    let pinhead = "Pinhead";

    if (complexity <= 2) {
        imageClassName = pinhead;
        imageCount = 1;
        title = "Pinhead"
    } else if (complexity === 3) {
        imageClassName = brain;
        imageCount = 1;
        title = "Requires Brain"
    } else if (complexity === 4) {
        imageClassName = brain;
        imageCount = 2;
        title = "Big Brain"
    } else {
        imageClassName = brain;
        imageCount = 6;
        title = "Gigantic Brain"
    }

    return (
        <div className="Icons" title={title}>
            {range(1, imageCount).map(_index => Icon(imageClassName))}
        </div>
    )
}

function Icon(imageClassName) {
    let className = `Icon ${imageClassName}`;
    return <div className={className}/>
}

function range(startIndex, endIndex) {
    let size = endIndex - startIndex + 1;
    return Array.from(new Array(size), (_x, i) => i + startIndex);
}

export default App;
