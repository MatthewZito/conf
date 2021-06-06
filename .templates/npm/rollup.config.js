import { babel } from '@rollup/plugin-babel';
import { nodeResolve } from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';

import babelrc from './build/babel.config';

import pkg from './package.json';

export default [
  {
    /* CommonJS */
    input: 'lib/index.js',
    output: {
      file: pkg.main,
      format: 'cjs',
      exports: 'default'
    },
    plugins: [
      nodeResolve(),
      commonjs(),
      babel({
        exclude: 'node_modules/**',
        babelrc: false,
        presets: [
          [
            '@babel/env',
            {
              modules: false,
              useBuiltIns: 'usage',
              targets: 'maintained node versions'
            }
          ]
        ],
        comments: true
      })
    ]
  },
  {
    /* UMD */
    input: 'lib/index.js',
    output: {
      file: pkg.browser.replace(/\.min.js$/, '.js'),
      format: 'umd',
      name: '<project>'
    },
    plugins: [
      nodeResolve({ browser: true }),
      commonjs(),
      babel({
        exclude: 'node_modules/**',
        babelrc: false,
        ...babelrc,
        babelHelpers: 'runtime',
        comments: true
      })
    ]
  },
  {
    /* Minified UMD */
    input: 'lib/index.js',
    output: {
      file: pkg.browser,
      format: 'umd',
      name: '<project>'
    },
    plugins: [
      nodeResolve({ browser: true }),
      commonjs(),
      babel({
        exclude: 'node_modules/**',
        babelrc: false,
        ...babelrc,
        babelHelpers: 'runtime',
        comments: true
      }),
      terser()
    ]
  },
  {
    /* ESM */
    input: 'lib/index.js',
    output: {
      file: pkg.module,
      format: 'es'
    },
    plugins: [
      nodeResolve(),
      commonjs(),
      babel({
        exclude: 'node_modules/**',
        babelrc: false,
        ...babelrc,
        babelHelpers: 'runtime',
        comments: true
      })
    ]
  }
];
