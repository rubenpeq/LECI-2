# Mecânica

## Vectores e Sistemas de Coordenadas

### Módulo de um vetor:
$$
|\vec{r}| = r = \sqrt{x^2 + y^2 + z^2}
$$

### Decomposição / Projeção de um vetor num referencial cartesiano:
$$
\vec{r} = \begin{pmatrix}r \cos \theta_x \\
r \cos \theta_y \\
r \cos \theta_z \end{pmatrix}
$$

### Vetor unitário — versor:
$$
|\vec{u}| = 1
$$

$$
\vec{u} = \begin{pmatrix}\frac{r_x}{|\vec{r}|} \\
\frac{r_y}{|\vec{r}|} \\
\frac{r_z}{|\vec{r}|}\end{pmatrix}
$$

### Distância entre dois pontos:
$$
\vec{r}_{AB} = \vec{r}_B - \vec{r}_A = \begin{pmatrix}x_B - x_A \\
y_B - y_A \\
z_B - z_A\end{pmatrix}
$$

$$
d(A,B) = |\vec{r}_{AB}| = \sqrt{(x_B - x_A)^2 + (y_B - y_A)^2 + (z_B - z_A)^2}
$$

## Movimento

### Movimento rectilíneo e uniforme:
$$
\vec{v} = \text{constante}
$$

### Movimento uniformemente acelarado:
$$
\vec{a} = \text{constante}
$$

### Posição:
$$
\vec{r} = x \hat{i} + y \hat{j} + z \hat{k}
$$

$$
\Delta \vec{r} = (x' - x) \hat{i} +(y' - y) \hat{j} + (z' - z) \hat{k}
$$

### Velocidade:
$$
\vec{v}_{med} = \frac{\Delta \vec{r}}{\Delta t}
$$

$$
\vec{v} = \lim_{\Delta t \to 0} \vec{v}_{\text{med}} = \lim_{\Delta t \to 0} \frac{\Delta \vec{r}}{\Delta t}
$$

$$
\vec{v} = \frac{d\vec{r}}{dt}
$$

$$
\int_{\vec{r}_0}^{\vec{r}} d \vec{r} = \int_{t_0}^{t} \vec{v} dt \iff \vec{r} - \vec{r}_0 = \int_{t_0}^{t} \vec{v} dt
$$

- **Se a velocidade for constante:**
$$
\vec{r} - \vec{r}_0 = \vec{v}(t - t_0) \vec{r} = \vec{r}_0 + \vec{v}(t - t_0)
$$

### Momento linear:
$$
\vec{p} = m \cdot \vec{v}
$$

# Campo Eletromagnético