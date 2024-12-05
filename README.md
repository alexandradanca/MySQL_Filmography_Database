<h1 align="center">
      🎥 Filmography Database
      <br />
      <hr />
      Movie Collections Based on Directors, Actors, and Themes
    </h1>
    <h3>Specifications for the Fictional Filmography Company:</h3>
    <ol>
      <li><h4>General Overview:</h4></li>
      <p>
        The company manages a collection of films based on criteria (director, actor, theme, etc.) 
        from Romania and other countries.
      </p>
      <li><h4>Filmmakers:</h4></li>
      <ul>
        <li>Attributes:</li>
        <ul>
          <li>Unique Filmmaker Code (IdFilmmaker).</li>
          <li>Filmmaker Name.</li>
          <li>Date of Birth.</li>
          <li>Country of Origin.</li>
        </ul>
      </ul>
      <li><h4>Awards:</h4></li>
      <ul>
        <li>Award ID (IdAward): Each award has a unique ID.</li>
        <li>Attributes:</li>
        <ul>
          <li>Year the award was given.</li>
          <li>Type of award.</li>
          <li>Filmmaker Code (IdFilmmaker).</li>
          <li>Film Code (IdFilm).</li>
        </ul>
        <li>Award Types:</li>
        <ul>
          <li>Oscar for Best Director</li>
          <li>Oscar for Best Film</li>
          <li>Oscar for Best Makeup and Hairstyling</li>
          <li>Oscar for Best Editing</li>
          <li>Oscar for Best Sound</li>
        </ul>
        <li>Attributes of each Award Type:</li>
        <ul>
          <li>Country of Origin.</li>
          <li>Locality.</li>
        </ul>
      </ul>
      <li><h4>Cast:</h4></li>
      <ul>
        <li>Attributes:</li>
        <ul>
          <li>Actor Code (IdActor).</li>
          <li>Salary (in USD).</li>
          <li>Role.</li>
          <li>Film Code (IdFilm).</li>
        </ul>
      </ul>
      <li><h4>Films:</h4></li>
      <ul>
        <li>Attributes:</li>
        <ul>
          <li>Unique Film Code (IdFilm).</li>
        </ul>
      </ul>
      <li><h4>Relationships:</h4></li>
      <ul>
        <li>A filmmaker can direct multiple films.</li>
        <li>An award can be given to two films or two filmmakers in the same year.</li>
        <li>A cast is composed of multiple actors related to a film.</li>
      </ul>
    </ol>
