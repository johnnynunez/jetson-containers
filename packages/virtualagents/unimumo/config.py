from jetson_containers import CUDA_ARCHITECTURES

def unimumo(version, requires=None, default=False):
    pkg = package.copy()

    if requires:
        pkg['requires'] = requires   

    pkg['name'] = f'unimumo:{version}'
    builder = pkg.copy()

    builder['name'] = f'unimumo:{version}-builder'
    builder['build_args'] = {**pkg['build_args'], **{'FORCE_BUILD': 'on'}}

    if default:
        pkg['alias'] = 'unimumo'
        builder['alias'] = 'unimumo:builder'

    return pkg, builder

package = [
    unimumo('0.1', default=True)
]
