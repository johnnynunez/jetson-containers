from jetson_containers import CUDA_ARCHITECTURES

def ompl(version, requires=None, default=False):
    pkg = package.copy()

    if requires:
        pkg['requires'] = requires   

    pkg['name'] = f'ompl:{version}'

    pkg['build_args'] = {
        'CUDAARCHS': ';'.join([str(x) for x in CUDA_ARCHITECTURES]),
        'OMPL_VERSION': version,
    }

    builder = pkg.copy()

    builder['name'] = f'ompl:{version}-builder'
    builder['build_args'] = {**pkg['build_args'], **{'FORCE_BUILD': 'on'}}

    if default:
        pkg['alias'] = 'ompl'
        builder['alias'] = 'ompl:builder'

    return pkg, builder

package = [
    ompl('2.2.5', default=True)
]
